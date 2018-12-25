require 'concurrent/map'
require_relative 'proxy'


class ProxyManager

  attr_reader :proxy_file_path, :ban_interval

  def initialize(site_config)
    @proxy_file_path = site_config[:proxy_file]
    @ban_interval    = site_config[:ban_interval]
    @proxies         = Concurrent::Map.new

    read_proxy_file
  end

  def get_proxy

  end

  def release_proxy(proxy)

  end

  def ban_proxy(proxy)

  end

private

  def read_proxy_file
    content = File.read(proxy_file_path)
    content

  end

end
