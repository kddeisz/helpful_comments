require 'rails'
require 'helpful_comments/railtie' if defined?(Rails)

module HelpfulComments
  
  autoload :FileWrapper, 'helpful_comments/file_wrapper'
  autoload :Base, 'helpful_comments/base'
  
  autoload :ControllerRoutes, 'helpful_comments/controller_routes'
  autoload :ModelSchemas, 'helpful_comments/model_schemas'
  
end
