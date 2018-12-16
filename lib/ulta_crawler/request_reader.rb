require_relative 'request_parsers/all'


class RequestReader

  def initialize(source_dir, parser=SimpleParser)
    @source_dir = source_dir
    @parser = parser
  end

  def read(max_count: nil)
    requests = []
    puts "Read requests in #{@source_dir} at #{Time.now}"

    Dir.foreach(dir) do |file|
      next if File.directory?(file) or file =~ /^\./
      puts "Read requests from #{file}"

      file_path = File.join(@source_dir, file)
      file_content = File.read(file_path)
      requests += @parser.to_requests(file_content)
      File.delete(file_path)

      break if max_count && requests.count > max_count
    end

    requests
  end

end
