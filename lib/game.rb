require_relative "./display"
require_relative "./presenter"
require_relative "./board"
require_relative "./player"
require_relative "./position_validator"
require_relative "./parse_input"
require_relative "./option_validator"
require_relative "./user"
require_relative "./tictactoe"

class Game
  attr_reader :user, :game_options, :validator

  def initialize(user:, game_options:, validator:)
    @user = user
    @game_options = game_options
    @validator = validator
  end

  def players
    game_options_descriptions = game_options.keys
    selection = selection(game_options_descriptions)
    game_option_description = game_options_descriptions[selection - 1]
    game_options[game_option_description]
  end

  private

  def player_prompt(game_options_descriptions)
    options = ""
    game_options_descriptions.each_with_index do |option, index|
      options += "  #{index + 1}.#{option}"
    end
    "Please select your game choice:#{options}"
  end

  def selection(game_options_descriptions)
    validator.options = game_options.keys.length
    user.valid_input(
      message: player_prompt(game_options_descriptions),
      validator: validator
    )
  end
end

if $PROGRAM_NAME == __FILE__
  display = Display.new($stdout, $stdin)
  presenter = TextPresenter.new
  board = Board.new
  position_validator = PositionValidator.new(board)
  parse_input = ParseInput.new
  user = User.new(display: display, parse_input: parse_input)
  x = "X"
  o = "O"
  first_human_player = HumanPlayer.new(user: user, token: x, validator: position_validator)
  second_human_player = HumanPlayer.new(user: user, token: o, validator: position_validator)
  first_computer_player = ComputerPlayer.new(token: x, board: board)
  second_computer_player = ComputerPlayer.new(token: o, board: board)
  game_options = {
    "Human vs. Human" => [first_human_player, second_human_player],
    "Human vs. Computer" => [first_human_player, second_computer_player],
    "Computer vs. Computer" => [first_computer_player, second_computer_player],
  }
  option_validator = OptionValidator.new
  players = Game.new(user: user, validator: option_validator, game_options: game_options).players
  TicTacToe.new(presenter, display, board, players).run
end
