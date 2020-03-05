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
  attr_reader :user, :game_options, :parse_input, :validator

  def initialize(user:, game_options:, parse_input:, validator:)
    @user = user
    @game_options = game_options
    @parse_input = parse_input
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
    user.valid_input(
      message: player_prompt(game_options_descriptions),
      parse_input: parse_input,
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
  user = User.new(display)
  human_player = HumanPlayer.new(user: user, token: "X", validator: position_validator, parse_input: parse_input)
  computer_player = ComputerPlayer.new(token: "O", board: board)
  game_options = {
    "You go first" => [human_player, computer_player],
    "Computer goes first" => [computer_player, human_player],
  }
  option_validator = OptionValidator.new(game_options.keys.length)
  players = Game.new(user: user, validator: option_validator, parse_input: parse_input, game_options: game_options).players
  TicTacToe.new(presenter, display, board, players).run
end
