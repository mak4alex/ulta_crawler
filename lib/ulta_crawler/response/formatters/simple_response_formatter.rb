class SimpleResponseFormatter

  SEPARATOR = "\r\n\r\n"

  def format(response)
    [response.request.format, response.headers, response.body].join(SEPARATOR)
  end

  def extension
    '.html'
  end

end
