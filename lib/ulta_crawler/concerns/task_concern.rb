require 'concurrent-ruby'


module TaskConcern

  attr_reader :task

  def create_task(opts)
    @task = Concurrent::TimerTask.new(opts) { yield }
  end

  def start
    init if defined?(init)
    task.execute
  end

  def shutdown
    task.shutdown
  end

  def running?
    task.running?
  end

end
