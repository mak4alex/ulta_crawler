require 'digest'
require 'uri'
require_relative 'formatters/request_formatter_factory'


class Request

  def self.set_formatter(type)
    @request_formatter = RequestFormatterFactory.get(type)
  end

  set_formatter(:simple)

  def self.from_string(string)
    @request_formatter.from_string(string)
  end

  def self.to_string(requests)
    @request_formatter.to_string(requests)
  end

  attr_accessor :url

  def initialize(url:)
    @url = url

    validate_url!
  end

  def url_hash
    Digest::MD5.hexdigest(url)
  end

  def format
    @request_formatter.to_string(self)
  end

  def validate_url!
    if url !~ URI::regexp
      raise StandardError, "Invalid url format: '#{url}'!"
    end
  end

end
