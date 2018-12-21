require 'concurrent-ruby'


module TaskConcern

  attr_reader task

  def create_task(opts)
    opts.merge!({ run_now: true })
    @task = Concurrent::TimerTask.new(opts) { yield }
  end

  def start
    task.execute
  end

  def shutdown
    task.shutdown
  end

  def running?
    task.running?
  end

end
