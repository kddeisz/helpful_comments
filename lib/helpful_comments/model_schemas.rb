module HelpfulComments
  class ModelSchemas < Base
    
    # takes a descendant of ActiveRecord::Base
    def initialize(klass)
      unless klass < ActiveRecord::Base
        raise ArgumentError, 'klass must descend from ActiveRecord::Base'
      end
      @klass = klass
    end
    
    # builds the lines to be put into the top of the file
    def build
      results = [%w[Field Type Null Default]]
      @klass.columns_hash.each do |name, column|
        default = case column.default
        when NilClass then ''
        when TrueClass then '1'
        when FalseClass then '0'
        else column.default
        end
        results << [name, column.sql_type, column.null ? 'YES' : 'NO', default]
      end
      lengths = results.transpose.map { |list| list.max_by { |segment| segment.to_s.length }.length + 1 }
      
      definition = results.map do |line|
        '# ' + line.map.with_index { |segment, index| "| %-#{lengths[index]}s" % segment }.join + "|\n"
      end
      header_line = '# ' + lengths.map { |length| '+' + '-' * (length + 1) }.join + "+\n"
      [header_line, definition.first, header_line] + definition[1..-1] + [header_line]
    end
    
    # puts the comments into the file
    def load
      @comments = self.build
      max_size = @comments.size
      
      written = false
      load_comments(Rails.root.join('app', 'models').to_s, max_size) do |file, line|
        if !written and line.lstrip.starts_with?('class') and !file.trailing?(@comments)
          file.write(@comments.join)
          written = true
        end
        file.write(line)
      end
    end
    
  end
end
