require_relative 'simple_request_formatter'

require 'pry'

class RequestFormatterFactory

  TYPES = %w{ simple }

  def self.get(type)
    case type
    when 'simple' then SimpleRequestFormatter.new
    else
      raise "Unknown type: #{type}! Available formatter types: #{TYPES}."
    end
  end

end
