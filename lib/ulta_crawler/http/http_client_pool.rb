require_relative 'http_client'


class HttpClientPool

  attr_reader :request_provider, :response_saver

  def initialize(request_provider, response_saver, proxy_manager, site_config)
    @request_provider = request_provider
    @response_saver   = response_saver
    @proxy_manager    = proxy_manager

    task_opts = {
      run_now: false,
      execution_interval: site_config[:crawl_interval],
      timeout_interval:   site_config[:crawl_timeout]
    }
    @clients = Array.new(site_config[:client_count]) { create_client(task_opts) }
  end

  def start
    @clients.each(&:start)
  end

  def shutdown
    @clients.each(&:shutdown)
  end

private

  def create_client(opts)
    HttpClient.new(request_provider, response_saver, proxy_manager, opts)
  end

end
