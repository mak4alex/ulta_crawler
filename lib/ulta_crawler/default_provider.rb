class DefaultProvider
  @opts = {
    worker_count: {
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
    response_dir: {
      desc: 'Some text',
      value: 'response'
    },
    http_client: {
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
    request_reader_interval: {
      desc: 'Some text',
      value: 60
    },
    request_reader_timeout: {
      desc: 'Some text',
      value: 60
    },
    crawl_request_interval: {
      desc: 'Some text',
      value: 3
    }
  }

  class << self

    def get_opt(key)
      @opts[key][:value]
    end

    alias_method :[], :get_opt

    def get_opts
      @opts
    end

    def merge_opts(opts)

    end

  end
end
