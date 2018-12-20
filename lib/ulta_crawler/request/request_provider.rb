require 'concurrent-ruby'
require_relative '../concerns/task_concern'

class RequestProvider
  include TaskConcern

  attr_reader :source_dir, :request_queue, :task_opts

  def initialize(source_dir, task_opts)
    @source_dir    = source_dir
    @task_opts     = task_opts
    @request_queue = RequestQueue.new
  end

  def get
    request_queue.pop
  end

private

  def read_request_files
    puts "Read requests in #{source_dir} at #{Time.now}"
    FileUtils.mkdir_p(source_dir)

    requests = []
    Dir.foreach(source_dir) do |file|
      next if File.directory?(file) or file =~ /^\./

      file_path = File.join(source_dir, file)
      puts "Read requests from #{file_path}"
      file_content = File.read(file_path)
      requests += Request.from_string(file_content)
      File.delete(file_path)
    end
    requests
  end

  def fill_queue
    read_request_files.each { |request| request_queue << request }
  end

  def create_task
    Concurrent::TimerTask.new(task_opts) do
      fill_queue
    end
  end
end
