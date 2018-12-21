require 'fileutils'
require_relative 'response_queue'
require_relative '../concerns/task_concern'


class ResponseSaver
  include TaskConcern

  attr_reader :dest_dir

  def initialize(dest_dir, opts)
    @dest_dir       = dest_dir
    @response_queue = ResponseQueue.new

    create_task(opts) { save_response }
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

end
