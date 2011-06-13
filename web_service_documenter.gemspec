$spec = Gem::Specification.new do |s|
  s.name = "web_service_documenter"
  s.version = '0.0.4'
  s.summary = "Document your json web services"

  s.authors  = ['Stephen Schor', 'Scott Taylor']
  s.email    = ['beholdthepanda@gmail.com', 'scott@railsnewbie.com']
  s.homepage = 'https://github.com/eastmedia/web_services_documenter'

  s.executables = ['web_service_documenter']

  s.add_dependency "multipart-post"
  # s.add_development_dependency "rspec"

  s.files = Dir['bin/*','lib/**/*']
  s.rubyforge_project = 'nowarning'
end
