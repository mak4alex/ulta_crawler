require 'uri'


class Request
  attr_accessor :url

  def initialize(url:)
    @url = url
  end

  def validate_url
    if url !~ URI::regexp
      raise StandardError, "Invalid url format: '#{url}'!"
    end
  end

end
