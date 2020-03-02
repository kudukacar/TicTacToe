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

  def selection(validator)
    player_prompt
    loop do
      selection_prompt
      selection = selection_valid(display.input, validator)
      return selection if selection && selection_available(selection, validator)
    end
  end

  private

  def player_prompt
    display.output(MESSAGES[:player_prompt] + token)
  end

  def selection_prompt
    display.output(MESSAGES[:select_space])
  end

  def selection_valid(selection, validator)
    validator.valid(selection) || display.output(MESSAGES[:invalid_entry])
  end

  def selection_available(selection, validator)
    validator.available(selection) || display.output(MESSAGES[:space_taken])
  end

  def input_to_integer(input)
    Integer(input)
  rescue
    0
  end
end
