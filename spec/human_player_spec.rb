require "spec_helper"
require "game"
require "ostruct"

RSpec.describe HumanPlayer do
  class ParseInputWithNoMethods end

  class ValidatorWithNoMethods end

  class UserWithOneValidInput
    def valid_input(message:, parse_input:, validator:)
      1
    end
  end

  describe "#selection" do
    it "returns the player's valid selection" do
      token = ""
      parse_input = ParseInputWithNoMethods.new
      validator = ValidatorWithNoMethods.new
      user = UserWithOneValidInput.new
      player = HumanPlayer.new(token: token, user: user, validator: validator, parse_input: parse_input)

      expect(player.selection).to eq(1)
    end
  end
end
