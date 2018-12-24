require_relative '../concerns/task_concern'
require_relative 'backends/http_backend_factory'


class HttpClient
  include TaskConcern

  attr_reader :site_config, :request_provider, :response_saver, :backend

  def initialize(request_provider, response_saver, site_config)
    @request_provider = request_provider
    @response_saver   = response_saver
    @config           = site_config
    @backend          = HttpBackendFactory.get(site_config[:http_backend_type])

    task_opts = {
      run_now: false,
      execution_interval: site_config[:crawl_interval],
      timeout_interval: site_config[:crawl_timeout]
    }
    create_task(task_opts) { process_request }
  end

private

  def init

  end

  def process_request
    request = request_provider.get
    response = backend.crawl(request)
    response_saver.save(response)
  end
end
