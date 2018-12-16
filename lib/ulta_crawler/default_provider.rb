class DefaultProvider

  def self.opts
    {
      worker_count: 3,
      name: 'default',
      work_dir: 'crawl_data',
      request_dir: 'request',
      response_dir: 'response',
      http_client: 'watir',
      screenshot: {
        enable: true,
        size: [1200, 1600]
      },
      main_loop_interval: 60,
      request_reader_interval: 60,
      request_reader_timeout: 60,
      crawl_request_interval: 3
    }
  end

end
