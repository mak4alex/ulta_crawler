module TaskConcern

  def task
    @task ||= create_task(task_opts)
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