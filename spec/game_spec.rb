require "spec_helper"
require "game"
require "fake_user"

RSpec.describe Game do
  class PlayerWithoutMethods end
  class ComputerPlayerWithoutMethods end
  class ValidatorWithInitialize
    attr_accessor :options
    def initialize
      @options = 1
    end
  end

  describe "#players" do
    it "returns an array of players based on the user's selection" do
      computer_player = ComputerPlayerWithoutMethods.new
      human_player = PlayerWithoutMethods.new
      game_options = {
        "You go first" => [human_player, computer_player],
        "Computer goes first" => [computer_player, human_player],
      }
      validator = ValidatorWithInitialize.new
      user = UserWithOneValidInput.new
      game = Game.new(user: user, game_options: game_options, validator: validator)

      expect(game.players).to eq([human_player, computer_player])
    end
  end
end
