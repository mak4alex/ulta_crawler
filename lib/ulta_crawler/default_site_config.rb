class DefaultSiteConfig
  @opts = {
    client_count: {
      desc: 'Some text',
      value: 3
    },
    site_name: {
      desc: 'Some text',
      value: 'default'
    },
    work_dir: {
      desc: 'Some text',
      value: 'crawl_data'
    },
    request_dir: {
      desc: 'Some text',
      value: 'request'
    },
    request_type: {
      desc: 'Some text',
      value: 'simple'
    },
    response_dir: {
      desc: 'Some text',
      value: 'response'
    },
    http_backend_type: {
      desc: 'Some text',
      value: 'watir'
    },
    screenshot: {
      desc: 'Some text',
      value: true
    },
    screenshot_dir: {
      desc: 'Some text',
      value: 'screenshot'
    },
    main_loop_interval: {
      desc: 'Some text',
      value: 60
    },
    request_interval: {
      desc: 'Some text',
      value: 60
    },
    request_timeout: {
      desc: 'Some text',
      value: 60
    },
    crawl_interval: {
      desc: 'Some text',
      value: 3
    },
    crawl_timeout: {
      desc: 'Some text',
      value: 3
    },
    response_interval: {
      desc: 'Some text',
      value: 3
    },
    response_timeout: {
      desc: 'Some text',
      value: 3
    }
  }

  class << self

    def configure
      #Request.set_formatter(formatter_type)


    end

    def get_opt(key)
      @opts[key][:value]
    end

    alias_method :[], :get_opt

    def get_opts
      @opts
    end

    def merge_opts(opts)

    end

    def site_dir
      @site_dir ||= File.join(get_opt(:work_dir), get_opt(:site_name))
    end

    def site_request_dir
      @request_dir ||= File.join(site_dir, get_opt(:request_dir))
    end

    def site_response_dir
      @response_dir ||= File.join(site_dir, get_opt(:response_dir))
    end

  end
end
