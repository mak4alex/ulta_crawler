require_relative 'ulta_crawler/crawler'
require_relative 'ulta_crawler/default_site_config'

class UltaCrawler

  def initialize(opts = {})
    provider = prepare_provider(opts)
    @crawler = Crawler.new(provider)
  end

  def run
    @crawler.run
  end

  def self.opts
    DefaultSiteConfig.get_opts.map do |name, opts|
      [name, opts[:desc], { type: opts[:type], default: opts[:value] }]
    end
  end

private

  def prepare_provider(opts)
    site_config_path = opts.delete(:site_config_path)

    if site_config_path
      load site_config_path
      provider_name = camel_case(File.basename(site_config_path, '.rb'))
      provider = Object.const_get(provider_name)
      DefaultSiteConfig.extend(provider)
    end

    DefaultSiteConfig.merge_opts(opts)
    DefaultSiteConfig
  end

  def camel_case(string)
    string.split('_').map(&:capitalize).join
  end

end
