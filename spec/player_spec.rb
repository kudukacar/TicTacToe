require "spec_helper"
require "tictactoe"

RSpec.describe Player do
  subject(:player) { Player.new(display) }

  class FakeDisplay
    attr_reader :messages

    def initialize(inputs: [])
      @inputs = inputs
      @messages = []
    end

    def output(message)
      @messages << message
      nil
    end

    def input
      @inputs.shift
    end
  end

  describe "#move" do
    let(:select_space_message) { "Please select your move by entering the number (1 - 9) corresponding to an empty space.  The spaces are numbered from the top left (1) to the bottom right (9) of the board." }

    context "with a valid entry between 1 and 9" do
      let(:display) { FakeDisplay.new(inputs: ["5"]) }

      it "prompts the player for a move" do
        player.move

        expect(display.messages).to eq([select_space_message])
      end

      it "returns the player's chosen space" do
        expect(player.move).to eq(5)
      end
    end

    context "with an invalid entry" do
      let(:display) { FakeDisplay.new(inputs: ["0", "?", "5"]) }

      it "prompts the player for a move until receiving a valid move" do
        invalid_entry_message = "Invalid entry."

        player.move

        expect(display.messages).to eq([select_space_message, invalid_entry_message, select_space_message, invalid_entry_message, select_space_message])
      end

      it "returns the player's chosen space" do
        expect(player.move).to eq(5)
      end
    end
  end
end
