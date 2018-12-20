require 'formatters/response_formatter_factory'


class Response

  def self.set_formatter(type)
    @response_formatter = ResponseFormatterFactory.get(type)
  end

  set_formatter(:simple)

  attr_reader :body, :headers, :request

  def initialize(body, headers, request)
    @body = body
    @headers = headers
    @request = request
  end

  def format
    @response_formatter.format(self)
  end

  def file_name
    "#{request.url_hash}.#{@response_formatter.extension}"
  end

end
