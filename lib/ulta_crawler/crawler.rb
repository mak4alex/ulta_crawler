require 'concurrent-ruby'
require_relative 'request_reader'
require_relative 'request_queue'


class Crawler

  def initialize(provider)
    @crawler_alive = true
    @provider = provider
    puts "Initialize crawler with provider: '#{provider}'"

    @request_queue  = RequestQueue.new
    @request_reader = RequestReader.new(request_dir)
  end

  def run
    start_todo_reader

    while crawler_alive?
      puts "Crawler alive and running at #{Time.now}"

      sleep @provider.opts[:main_loop_interval]
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

  def start_todo_reader
    @task_todo_reader = Concurrent::TimerTask.new(
        execution_interval: @provider.opts[:request_reader_interval],
        timeout_interval: @provider.opts[:request_reader_timeout],
        run_now: true) do
      @request_reader.read.each { |request| @request_queue << request }
    end
    @task_todo_reader.execute
  end


  def shutdown_tasks
    @task_todo_reader.shutdown

  end


  def site_dir
    @site_dir ||= File.join(@provider.opts[:work_dir], @provider.opts[:name])
  end


  def request_dir
    @request_dir ||= File.join(site_dir, @provider.opts[:request_dir])
  end

end
