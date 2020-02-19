class Player
  def initialize(display)
    @display = display
  end

  def selection
    loop do
      @display.output("Please select your move by entering the number (1 - 9) corresponding to an empty space.  The spaces are numbered from the top left (1) to the bottom right (9) of the board.")

      selection = input_to_integer(@display.input)

      selection.between?(1, 9) ? (return selection) : @display.output("Invalid entry.")
    end
  end

  def input_to_integer(input)
    Integer(input)
  rescue
    0
  end
end
