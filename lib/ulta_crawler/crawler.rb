require_relative 'http/http_client_pool'
require_relative 'request/request_provider'
require_relative 'response/response_saver'


class Crawler

  attr_reader :tasks

  def initialize(provider)
    @crawler_alive = true
    @provider = provider
    puts "Initialize crawler with provider: '#{provider}'"

    @request_provider = RequestProvider.new(
      request_dir, @provider[:request_formatter_type], {
      execution_interval: @provider[:request_reader_interval],
      timeout_interval: @provider[:request_reader_timeout],
    })
    @response_saver   = ResponseSaver.new(
      response_dir, @provider[:response_formatter_type], {
      execution_interval: @provider[:response_saver_interval],
      timeout_interval: @provider[:response_saver_timeout],
    })
    @http_client_pool = HttpClientPool.new(
      @request_provider, @response_saver, {
      client_count: @provider[:client_count],
      execution_interval: @provider[:response_saver_interval],
      timeout_interval: @provider[:response_saver_timeout],
    })

    @tasks = [@request_provider, @http_client_pool, @response_saver]
  end

  def run
    start_tasks

    while running?
      puts "Crawler alive and running at #{Time.now}"

      sleep( @provider[:main_loop_interval])
    end
  end

  def shutdown
    shutdown_tasks
    @crawler_alive = false
  end

  def running?
    @crawler_alive
  end

private

  def start_tasks
    tasks.each(&:start)
  end

  def shutdown_tasks
    tasks.each(&:shutdown)
  end

  def site_dir
    @site_dir ||= File.join(@provider[:work_dir], @provider[:site_name])
  end

  def request_dir
    @request_dir ||= File.join(site_dir, @provider[:request_dir])
  end

  def response_dir
    @response_dir ||= File.join(site_dir, @provider[:response_dir])
  end

end
