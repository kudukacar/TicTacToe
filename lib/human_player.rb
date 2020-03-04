class HumanPlayer
  attr_reader :display, :token, :validator

  MESSAGES = {
    player_prompt: "Go ",
    select_space: "Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space.",
    invalid_entry: "Invalid entry.",
    space_taken: "Selection taken and not available.",
  }

  def initialize(display:, token:, validator:)
    @display = display
    @token = token
    @validator = validator
  end

  def selection(board)
    player_prompt
    loop do
      selection_prompt
      selection = input_to_integer(display.input)
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
    validation_result = validator.validate(selection, board)
    return selection if validation_result.position
    display.output(MESSAGES[validation_result.status])
  end

  def input_to_integer(input)
    Integer(input)
  rescue
    0
  end
end
