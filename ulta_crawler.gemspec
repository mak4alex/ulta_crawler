Gem::Specification.new do |s|
  s.name        = 'ulta-crawler'
  s.version     = '0.0.1'
  s.date        = '2018-12-16'
  s.executables << 'ulta-crawler'
  s.required_ruby_version = '>= 2.3.0'

  s.summary     = 'General purpose crawler'

  s.authors     = ['mak4alex']
  s.email       = 'mak4alex@gmail.com'
  s.homepage    = 'https://github.com/mak4alex/ulta_crawler'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split("\n")
end
