module HelpfulComments
  class ControllerRoutes < Base
    
    # takes a controller
    def initialize(klass)
      @klass = klass
    end
    
    # builds the lines to be put into the file
    def build
      controller_name = @klass.name.gsub(/Controller$/, '').underscore
      Rails.application.routes.routes.each_with_object({}) do |route, comments|
        if route.defaults[:controller] == controller_name
          verb_match = route.verb.to_s.match(/\^(.*)\$/)
          verbs = verb_match.nil? ? '*' : verb_match[1]
          (comments[route.defaults[:action]] ||= []) << "#{verbs} #{route.ast}"
        end
      end
    end
    
    # puts the comments into the file
    def load
      @comments = self.build
      max_size = @comments.values.max_by(&:size).try(:size)
      
      load_comments(Rails.root.join('app', 'controllers').to_s, max_size) do |file, line|
        if get_finder === line
          found_method = $1
          
          comments = build_comments(found_method, line.chomp.match(/^(\s*)[^\s]*/)[1])
          file.write(comments.join) unless file.trailing?(comments)
          
          @comments.delete(found_method)
          get_finder(true)
        end
        
        file.write(line)
      end
    end
    
    private
      
      # build the comments from the method with the given indentation
      def build_comments(method, indent)
        @comments[method].map { |comment| "#{indent}# #{comment}\n" }
      end
      
      # the regex for checking this line for method definitions
      def get_finder(rebuild = false)
        @finder = /^\s*def\s+(#{@comments.keys.join('|')})\s*$/ if rebuild or @finder.nil?
        @finder
      end
      
  end
end
