require_relative 'ulta_crawler/crawler'
require_relative 'ulta_crawler/default_provider'
require_relative 'ulta_crawler/request'
require_relative 'ulta_crawler/request_reader'


class UltaCrawler

  def initialize(opts = {})
    provider = prepare_provider(opts)
    @crawler = Crawler.new(provider)
  end

  def run
    @crawler.run
  end

  def self.opts
    DefaultProvider.get_opts.map do |name, opts|
      [name, opts[:desc], { type: opts[:type], default: opts[:value] }]
    end
  end

private

  def prepare_provider(opts)
    provider_path = opts.delete(:provider_path)

    if provider_path
      load provider_path
      provider_name = camel_case(File.basename(provider_path, '.rb'))
      provider = Object.const_get(provider_name)
      DefaultProvider.extend(provider)
    end

    DefaultProvider.merge_opts(opts)
    DefaultProvider
  end

  def camel_case(string)
    string.split('_').map(&:capitalize).join
  end

end
