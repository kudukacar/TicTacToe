class Player
  def initialize(display)
    @display = display
  end

  def selection(board)
    loop do
      @display.output("Please select your move by entering the number (1 - 9, from top left to bottom right) corresponding to an empty space.")
      selection = input_to_integer(@display.input)
      if selection_valid(selection)
        return selection if selection_available(selection, board)
      end
    end
  end

  def selection_valid(pos)
    pos.between?(1, 9) ? pos : @display.output("Invalid entry.")
  end

  def selection_available(pos, board)
    board.is_available?(pos) ? pos : @display.output("Selection taken and not available.")
  end

  def input_to_integer(input)
    Integer(input)
  rescue
    0
  end
end
