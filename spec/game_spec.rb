require "spec_helper"
require "game"

RSpec.describe Game do
  class UserWithOneValidInput
    def valid_input(message:, parse_input:, validator:)
      1
    end
  end

  class PlayerWithoutMethods end
  class ComputerPlayerWithoutMethods end
  class ParseInputWithNoMethods end
  class ValidatorWithNoMethods end

  describe "#players" do
    it "returns an array of players based on the user's selection" do
      computer_player = ComputerPlayerWithoutMethods.new
      human_player = PlayerWithoutMethods.new
      game_options = {
        "You go first" => [human_player, computer_player],
        "Computer goes first" => [computer_player, human_player],
      }
      parse_input = ParseInputWithNoMethods.new
      validator = ValidatorWithNoMethods.new
      user = UserWithOneValidInput.new
      game = Game.new(user: user, game_options: game_options, parse_input: parse_input, validator: validator)

      expect(game.players).to eq([human_player, computer_player])
    end
  end
end
