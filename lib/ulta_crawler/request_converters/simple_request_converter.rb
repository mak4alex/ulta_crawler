require_relative '../request'

class SimpleRequestConverter

  SEPARATOR = "\n".freeze

  def from_string(string)
    urls = string.split(SEPARATOR).map!(&:strip)
    urls.map! { |url| Request.new(url: url) }
  end

  def to_string(requests)
    requests.map(:url).join(SEPARATOR)
  end

end
