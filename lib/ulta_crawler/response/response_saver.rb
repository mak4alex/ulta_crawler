require 'concurrent-ruby'
require_relative 'response/queue'
require_relative 'concerns/task_concern'


class ResponseSaver
  include TaskConcern

  def initialize(dest_dir, formatter_type, task_opts)
    @dest_dir           = dest_dir
    @response_converter = formatter
    @task_opts          = task_opts
    @response_queue     = ResponseQueue.new
  end

  def save(response)
    @response_queue << response
  end

private

  def write_to_file(response)

  end

  def save_responses
    while @response_queue.any?
      write_to_file(@response_queue.get)
    end
  end

  def create_task(opts)
    Concurrent::TimerTask.new(opts) do
      save_responses
    end
  end

end
