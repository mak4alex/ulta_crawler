require_relative 'request_parsers/all'


class RequestProvider

  def initialize(source_dir, request_converter=SimpleRequestConverter)
    @source_dir = source_dir
    @request_converter = request_converter
    @request_queue    = RequestQueue.new
  end

  def get
    @request_queue.get
  end

  def fill_queue
    read_request_files.each { |request| @request_queue << request }
  end

private

  def read_request_files(max_count: nil)
    requests = []
    puts "Read requests in #{@source_dir} at #{Time.now}"

    Dir.foreach(dir) do |file|
      next if File.directory?(file) or file =~ /^\./
      puts "Read requests from #{file}"

      file_path = File.join(@source_dir, file)
      file_content = File.read(file_path)
      requests += @request_converter.from_string(file_content)
      File.delete(file_path)

      break if max_count && requests.count > max_count
    end

    requests
  end

end
