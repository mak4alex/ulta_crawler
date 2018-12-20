require 'thread'


class ResponseQueue

  def initialize
    @queue = Queue.new
  end

  def pop
    @queue.pop(non_block=false)
  end

  def push(request)
    @queue.push(request)
  end
  alias << push

  def any?
    not empty?
  end

  def empty?
    @queue.empty?
  end

end
