namespace :helpful_comments do
  
  desc 'Load controller route comments'
  task controller_routes: :environment do
    if (controller_name = ENV['CONTROLLER']).present?
      HelpfulComments::ControllerRoutes.new(controller_name.constantize).load
    else
      Rails.application.eager_load!
      HelpfulComments::ControllerRoutes.load(*ApplicationController.descendants)
    end
  end
  
  desc 'Load model schema comments'
  task model_schemas: :environment do
    if (model_name = ENV['MODEL']).present?
      HelpfulComments::ModelSchemas.new(model_name.constantize).load
    else
      Rails.application.eager_load!
      HelpfulComments::ModelSchemas.load(*ActiveRecord::Base.descendants)
    end
  end
  
end
