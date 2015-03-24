$:.push File.expand_path('../lib', __FILE__)

require 'helpful_comments/version'

Gem::Specification.new do |s|
  s.name        = 'helpful_comments'
  s.version     = HelpfulComments::VERSION
  s.authors     = ['Kevin Deisz']
  s.email       = ['kevin.deisz@gmail.com']
  s.homepage    = 'https://github.com/kddeisz/helpful_comments'
  s.summary     = 'Puts helpful comments into your models and controllers.'
  s.description = 'Yay helpful comments.'
  s.license     = 'MIT'
  
  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  
  s.add_dependency 'rails'
end
