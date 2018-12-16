require_relative '../request'

class SimpleParser

  SEPARATOR = "\n".freeze

  def to_requests(text)
    urls = text.split(SEPARATOR).map!(&:strip)
    urls.map! { |url| Request.new(url: url) }
  end

  def to_text(requests)
    requests.map(:url).join(SEPARATOR)
  end

end
