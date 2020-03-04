class ParseInput
  attr_reader :display
  
  def initialize(display)
    @display = display
  end

  def input_to_integer
    Integer(display.input)
  rescue
    0
  end
end