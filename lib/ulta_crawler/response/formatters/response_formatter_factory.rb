require_relative 'simple_response_formatter'


class ResponseFormatterFactory

  TYPES = %w{ simple }

  def self.get(type)
    case type
    when 'simple' then SimpleResponseFormatter.new
    else
      raise "Unknown type: #{type}! Available formatter types: #{TYPES}."
    end
  end

end
