require 'concurrent-ruby'


require_relative 'request_provider'


class Crawler

  def initialize(provider)
    @crawler_alive = true
    @provider = provider
    puts "Initialize crawler with provider: '#{provider}'"

    @request_provider = RequestProvider.new(request_dir)

    @response_saver   = ResponseSaver.new(response_dir)
  end

  def run
    start_tasks

    while crawler_alive?
      puts "Crawler alive and running at #{Time.now}"

      sleep @provider[:main_loop_interval]
    end

    shutdown_tasks
  end

  def stop
    @crawler_alive = false
  end

  def crawler_alive?
    @crawler_alive
  end

private

  def start_tasks
    start_request_provider

  end

  def start_request_provider
    task_options = {
      execution_interval: @provider[:request_reader_interval],
      timeout_interval: @provider[:request_reader_timeout],
      run_now: true
    }

    @task_request_provider = Concurrent::TimerTask.new(task_options) do
      @request_provider.fill_queue
    end

    @task_request_provider.execute
  end

  def shutdown_tasks
    @task_request_provider.shutdown

  end

  def site_dir
    @site_dir ||= File.join(@provider[:work_dir], @provider[:site_name])
  end

  def request_dir
    @request_dir ||= File.join(site_dir, @provider[:request_dir])
  end

  def response_dir
    @request_dir ||= File.join(site_dir, @provider[:response_dir])
  end

end
