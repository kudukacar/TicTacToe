class HumanPlayer
  attr_reader :display, :token

  MESSAGES = {
    player_prompt: "Go ",
    select_space: "Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space.",
    invalid_entry: "Invalid entry.",
    space_taken: "Selection taken and not available.",
  }

  def initialize(display:, token:)
    @display = display
    @token = token
  end

  def selection(board)
    player_prompt(board)
    loop do
      selection_prompt
      selection = input_to_integer(display.input)
      return selection if selection_valid(selection) && selection_available(selection, board)
    end
  end

  def player_prompt(board)
    display.output(MESSAGES[:player_prompt] + token)
  end

  def selection_prompt
    display.output(MESSAGES[:select_space])
  end

  def selection_valid(position)
    position.between?(1, 9) ? position : display.output(MESSAGES[:invalid_entry])
  end

  def selection_available(position, board)
    board.is_available?(position) ? position : display.output(MESSAGES[:space_taken])
  end

  def input_to_integer(input)
    Integer(input)
  rescue
    0
  end
end
