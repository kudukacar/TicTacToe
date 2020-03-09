require "spec_helper"
require "game"
require "ostruct"

RSpec.describe HumanPlayer do
  class ValidatorWithNoMethods end

  class UserWithOneValidInput
    def valid_input(message:, validator:)
      1
    end
  end

  describe "#selection" do
    it "returns the player's valid selection" do
      token = ""
      validator = ValidatorWithNoMethods.new
      user = UserWithOneValidInput.new
      player = HumanPlayer.new(token: token, user: user, validator: validator)

      expect(player.selection).to eq(1)
    end
  end
end
