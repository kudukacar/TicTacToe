class Player
  attr_reader :display, :messages

  def initialize(display)
    @display = display
    @messages = {
      select_space: "Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space.",
      invalid_entry: "Invalid entry.",
      space_taken: "Selection taken and not available.",
    }
  end

  def selection(board)
    loop do
      display.output(messages[:select_space])
      selection = input_to_integer(display.input)
      return selection if selection_valid(selection) && selection_available(selection, board)
    end
  end

  def selection_valid(pos)
    pos.between?(1, 9) ? pos : display.output(messages[:invalid_entry])
  end

  def selection_available(pos, board)
    board.is_available?(pos) ? pos : display.output(messages[:space_taken])
  end

  def input_to_integer(input)
    Integer(input)
  rescue
    0
  end
end
