require 'watir'


class WatirBackend



  def initialize
    @client = Watir::Browser.new( :firefox, proxy: proxy)
  end

  def crawl(request)

  end

  def set_proxy(proxy)

  end

end
