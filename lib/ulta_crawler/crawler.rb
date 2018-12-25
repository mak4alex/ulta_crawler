require_relative 'http/http_client_pool'
require_relative 'proxy/proxy_manager'
require_relative 'request/request_provider'
require_relative 'response/response_saver'


class Crawler

  attr_reader :tasks, :site_config

  def initialize(site_config)
    @crawler_alive = true
    @site_config   = site_config
    puts "Initialize crawler with site_config: '#{site_config}'"

    @request_provider = RequestProvider.new(site_config)
    @response_saver   = ResponseSaver.new(site_config)
    @proxy_manager    = ProxyManager.new(site_config)
    @http_client_pool = HttpClientPool.new(
        @request_provider, @response_saver, @proxy_manager, site_config)

    @tasks = [@request_provider, @http_client_pool, @response_saver]

    trap_signals
  end

  def run
    start_tasks

    while running?
      puts "Crawler alive and running at #{Time.now}"
      sleep(site_config[:main_loop_interval])
    end

    exit(0)
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
    puts 'Start crawler tasks'
    tasks.each(&:start)
  end

  def shutdown_tasks
    puts 'Shutdown crawler tasks'
    tasks.each(&:shutdown)
  end

  def trap_signals
    trap('SIGINT') { shutdown }
    trap('TERM') { shutdown }
  end

end
