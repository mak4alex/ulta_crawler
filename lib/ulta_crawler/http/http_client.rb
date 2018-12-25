require_relative '../concerns/task_concern'
require_relative 'backends/http_backend_factory'


class HttpClient
  include TaskConcern

  attr_reader :site_config, :request_provider, :response_saver, :backend,
              :proxy_manager

  def initialize(request_provider, response_saver, proxy_manager, site_config)
    @request_provider = request_provider
    @response_saver   = response_saver
    @proxy_manager    = proxy_manager
    @config           = site_config
    @client_ready     = false

    task_opts = {
      run_now: false,
      execution_interval: site_config[:crawl_interval],
      timeout_interval: site_config[:crawl_timeout]
    }
    create_task(task_opts) { process_request }
  end

private

  def init_client
    backend = HttpBackendFactory.get(site_config[:http_backend_type])
    backend.set_proxy(proxy_manager.get_proxy)

    if site_config.respond_to?(:init)
      site_config.init(backend)
    end

    @client_ready = true
  end

  def reset_client
    backend.close
    proxy_manager.release_proxy(backend.proxy)

    @client_ready = false
  end

  def process_request
    if client_ready?
      request = request_provider.get
      response = backend.crawl(request)
      response_saver.save(response)
    else
      init_client
    end
  end


  def client_ready?
    @client_ready
  end

end
