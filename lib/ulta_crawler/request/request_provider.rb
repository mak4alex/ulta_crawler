require 'concurrent-ruby'
require_relative '../concerns/task_concern'

class RequestProvider
  include TaskConcern

  attr_reader :source_dir, :request_converter, :request_queue, :task_opts

  def initialize(source_dir, formatter_type, task_opts)
    @source_dir        = source_dir
    @request_converter = request_converter
    @task_opts         = task_opts
    @request_queue     = RequestQueue.new
  end

  def get
    request_queue.get
  end

private

  def read_request_files
    requests = []
    puts "Read requests in #{source_dir} at #{Time.now}"

    Dir.foreach(dir) do |file|
      next if File.directory?(file) or file =~ /^\./

      file_path = File.join(source_dir, file)
      puts "Read requests from #{file_path}"
      file_content = File.read(file_path)
      requests += request_converter.from_string(file_content)
      File.delete(file_path)
    end

    requests
  end

  def fill_queue
    read_request_files.each { |request| request_queue << request }
  end

  def create_task(opts)
    Concurrent::TimerTask.new(opts) do
      fill_queue
    end
  end
end
