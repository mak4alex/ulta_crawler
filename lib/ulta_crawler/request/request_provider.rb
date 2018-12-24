require 'fileutils'
require_relative '../concerns/task_concern'
require_relative 'request'
require_relative 'request_queue'


class RequestProvider
  include TaskConcern

  attr_reader :site_request_dir, :request_queue

  def initialize(site_config)
    @site_request_dir = site_config.site_request_dir
    @request_queue    = RequestQueue.new
    Request.set_formatter(site_config[:request_type])

    task_opts = {
      run_now: true,
      execution_interval: site_config[:request_interval],
      timeout_interval: site_config[:request_timeout]
    }
    create_task(task_opts) { fill_queue }
  end

  def get
    request_queue.pop
  end

private

  def read_request_files
    puts "Read requests in #{site_request_dir} at #{Time.now}"
    FileUtils.mkdir_p(site_request_dir)

    requests = []
    Dir.foreach(site_request_dir) do |file|
      next if File.directory?(file) or file =~ /^\./

      file_path = File.join(site_request_dir, file)
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

end
