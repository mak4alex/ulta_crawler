require '../concerns/task_concern'


class HttpClient
  include TaskConcern

  attr_reader :request_provider, :response_saver, :opts

  def initialize(request_provider, response_saver, opts)
    @request_provider = request_provider
    @response_saver   = response_saver
    @opts             = opts

    create_task(opts) {  }
  end


end
