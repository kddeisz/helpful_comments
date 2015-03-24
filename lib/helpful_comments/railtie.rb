module HelpfulComments
  class Railtie < Rails::Railtie
    
    rake_tasks do
      load 'tasks/helpful_comments_tasks.rake'
    end
    
  end
end
