require 'concurrent-ruby'
require 'fileutils'
require_relative 'response/queue'
require_relative 'concerns/task_concern'


class ResponseSaver
  include TaskConcern

  attr_reader :dest_dir, :task_opts

  def initialize(dest_dir, task_opts)
    @dest_dir       = dest_dir
    @task_opts      = task_opts
    @response_queue = ResponseQueue.new
  end

  def save(response)
    @response_queue << response
  end

private

  def save_response
    response = @response_queue.pop
    path = File.join(dest_dir, response.file_name)
    FileUtils.mkdir_p(dest_dir)
    File.write(path, response.format)
  end

  def create_task
    Concurrent::TimerTask.new(task_opts) do
      save_response
    end
  end

end
