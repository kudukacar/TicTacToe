class HumanPlayer
  attr_reader :display, :token, :validator, :parse_input

  MESSAGES = {
    player_prompt: "Go ",
    select_space: "Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space."
  }

  def initialize(display:, token:, validator:, parse_input:)
    @display = display
    @token = token
    @validator = validator
    @parse_input = parse_input
  end

  def selection(board)
    player_prompt
    loop do
      selection_prompt
      selection = parse_input.input_to_integer
      return selection if validate_selection(selection, board)
    end
  end

  private

  def player_prompt
    display.output(MESSAGES[:player_prompt] + token)
  end

  def selection_prompt
    display.output(MESSAGES[:select_space])
  end

  def validate_selection(selection, board)
    validation_result = validator.validate_board_position(selection, board)
    return selection if validation_result == selection
    display.output(validation_result)
  end
end
