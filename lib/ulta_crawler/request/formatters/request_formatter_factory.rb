require_relative 'simple_request_formatter'


class RequestFormatterFactory

  TYPES = [:simple]

  def self.get(formatter_type)
    case formatter_type
    when :simple then SimpleRequestFormatter.new
    else
      raise "Unknown type: #{formatter_type}! Available formatter types: #{TYPES}."
    end
  end

end
