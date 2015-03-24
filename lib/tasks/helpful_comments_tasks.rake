namespace :helpful_comments do
  
  desc 'Load controller route comments'
  task controller_routes: :environment do
    controllers = []
    if (controller_name = ENV['CONTROLLER']).present?
      controllers << controller_name.classify.constantize
    else
      Dir[Rails.root.join('app', 'controllers', '*').to_s].entries.each do |filepath|
        controllers << Pathname.new(filepath).basename('.rb').classify.constantize
      end
    end
    
    HelpfulComments::ControllerRoutes.load_for(*controllers)
  end
  
  desc 'Load model schema comments'
  task model_schemas: :environment do
    models = []
    if (model_name = ENV['MODEL']).present?
      models << model_name.classify.constantize
    else
      Dir[Rails.root.join('app', 'models', '*').to_s].entries.each do |filepath|
        models << Pathname.new(filepath).basename('.rb').classify.constantize
      end
    end
    
    HelpfulComments::ModelSchemas.load_for(*controllers)
  end
  
end
