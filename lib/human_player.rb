class HumanPlayer
  attr_reader :user, :token, :validator

  def initialize(token:, user:, validator:)
    @token = token
    @user = user
    @validator = validator
  end

  def selection
    user.valid_input(message: player_prompt, validator: validator)
  end

  private

  def player_prompt
    "Go #{token}.  Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space."
  end
end
