require 'http_client'


class HttpClientPool

  attr_reader :request_provider, :response_saver, :opts

  def initialize(request_provider, response_saver, opts = {})
    @request_provider = request_provider
    @response_saver = response_saver
    @opts    = opts
    @clients = Array.new(opts[:client_count]) { create_client }
  end

  def start
    @clients.each(&:start)
  end

  def shutdown
    @clients.each(&:shutdown)
  end

private

  def create_client
    HttpClient.new(request_provider, response_saver, opts)
  end

end
