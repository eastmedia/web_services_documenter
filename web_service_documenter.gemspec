$spec = Gem::Specification.new do |s|
  s.name = "web_service_documenter"
  s.version = '0.0.1'
  s.summary = "Deploy with masculine confidence"

  s.authors  = ['Scott Taylor', 'Stephen Schor']
  s.email    = ['scott@railsnewbie.com', 'beholdthepanda@gmail.com']
  s.homepage = 'https://github.com/eastmedia/web_services_documenter'

  s.executables = ['web_service_documenter']

  s.files = Dir['bin/*','lib/**/*']
  s.rubyforge_project = 'nowarning'
end
