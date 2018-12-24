require_relative 'curb_backend'
require_relative 'watir_backend'


class HttpBackendFactory

  TYPES = %w{ curb watir }

  def self.get(backend_type)
    case backend_type
    when 'curb' then CurbBackend.new
    when 'watir' then WatirBackend.new
    else
      raise "Unknown type: #{backend_type}! Available formatter types: #{TYPES}."
    end
  end

end
