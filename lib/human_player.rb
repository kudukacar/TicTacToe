class HumanPlayer
  attr_reader :user, :token, :validator, :parse_input

  def initialize(token:, user:, validator:, parse_input:)
    @token = token
    @user = user
    @validator = validator
    @parse_input = parse_input
  end

  def selection
    user.valid_input(message: player_prompt, parse_input: parse_input, validator: validator)
  end

  private

  def player_prompt
    "Go #{token}.  Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space."
  end
end
