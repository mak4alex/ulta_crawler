require_relative 'simple_response_formatter'


class ResponseFormatterFactory

  TYPES = [:simple]

  def self.get(formatter_type)
    case formatter_type
    when :simple then SimpleResponseFormatter.new
    else
      raise "Unknown type: #{formatter_type}! Available formatter types: #{TYPES}."
    end
  end

end
