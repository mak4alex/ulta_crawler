module TaskConcern

  def task
    task_opts.merge!({ run_now: true })
    @task ||= create_task
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
