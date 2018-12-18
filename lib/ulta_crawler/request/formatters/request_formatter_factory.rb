require_relative 'simple_request_formatter'


class RequestFormatterFactory

  FORMATTER_TYPES = [:simple]

  def self.get_formatter(formatter_type)
    case formatter_type
    when :simple then SimpleRequestFormatter.new
    else
      raise "Unknown formatter: #{formatter_type}! Formats: #{FORMATTER_TYPES}"
    end
  end

end
