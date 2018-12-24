require 'fileutils'
require_relative '../concerns/task_concern'
require_relative 'response_queue'


class ResponseSaver
  include TaskConcern

  attr_reader :site_response_dir

  def initialize(site_config)
    @site_response_dir = site_config.site_response_dir
    @response_queue    = ResponseQueue.new

    task_opts = {
      run_now: true,
      execution_interval: site_config[:response_interval],
      timeout_interval: site_config[:response_timeout]
    }
    create_task(task_opts) { save_response }
  end

  def save(response)
    @response_queue << response
  end

private

  def save_response
    response = @response_queue.pop
    path = File.join(site_response_dir, response.file_name)
    FileUtils.mkdir_p(site_response_dir)
    File.write(path, response.format)
  end

end
