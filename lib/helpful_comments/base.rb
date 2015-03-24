module HelpfulComments
  class Base
    
    # convenience helper for multiple classes
    def self.load(*klasses)
      klasses.each { |klass| self.new(klass).load }
    end
    
    private
      
      def load_comments(directory, max_size, &block)
        filepath = File.join(directory, @klass.name.underscore + '.rb').to_s
        return unless File.file?(filepath)
        
        tempfile = Tempfile.new([@klass.name, '.rb'])
        if @comments.any?
          File.open(tempfile, 'w') do |file|
            file_wrapper = FileWrapper.new(file, max_size)
            
            File.foreach(filepath) do |line|
              yield file_wrapper, line
            end
          end
          
          FileUtils.mv(tempfile, filepath)
        end
      end
      
  end
end
