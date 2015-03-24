class HelpfulComments::FileWrapper
  
  # build a new file wrapper
  def initialize(file, max_lines)
    @file = file
    @lines = Array.new(max_lines, '')
  end
  
  # true if the last written lines to the file match the given lines
  def trailing?(lines)
    raise ArgumentError, 'lines too long' if lines.size > @lines.size
    @lines[(@lines.size - lines.size)..-1] == lines
  end
  
  # write the line to the file
  def write(string)
    @lines.shift
    @lines << string
    @file.write(string)
  end
  
end
