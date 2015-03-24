$:.push File.expand_path('../lib', __FILE__)

require 'helpful_comments/version'

Gem::Specification.new do |s|
  s.name        = 'helpful_comments'
  s.version     = HelpfulComments::VERSION
  s.authors     = ['Kevin Deisz']
  s.email       = ['kevin.deisz@gmail.com']
  s.homepage    = 'TODO'
  s.summary     = 'Puts helpful comments into your models and controllers.'
  s.description = 'Yay helpful comments.'
  s.license     = 'MIT'
  
  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']
  
  s.add_dependency 'rails'
  
  s.add_development_dependency 'sqlite3'
end
