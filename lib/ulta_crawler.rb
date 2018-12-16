require_relative 'ulta_crawler/crawler'
require_relative 'ulta_crawler/request'
require_relative 'ulta_crawler/request_reader'


class UltaCrawler

  DEFAULT_PROVIDER_PATH = './ulta_crawler/default_provider.rb'.freeze

  def initialize(opts = {})
    provider_path = opts.delete(:provider_path) || default_provider_path
    load provider_path

    provider_name = File.basename(provider_path, '.rb').split('_').map(&:capitalize).join
    provider = Object.const_get(provider_name)

    provider.opts.merge(opts)
    provider.opts.freeze

    @crawler = Crawler.new(provider)
  end

  def run
    @crawler.run
  end

private

  def default_provider_path
    gem_lib_dir = File.dirname(__FILE__)
    File.join(gem_lib_dir, DEFAULT_PROVIDER_PATH)
  end

end
