require "spec_helper"
require "tictactoe"

RSpec.describe Player do
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
    context "with a valid entry between 1 and 9" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["5"]) }

      it "prompts the player for a move" do
        player.selection

        expect(display.messages.length).to eq(1)
      end

      it "returns the player's chosen space" do
        expect(player.selection).to eq(5)
      end
    end

    context "with an invalid entry" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["0", "?", "5"]) }

      it "prompts the player for a move until receiving a valid move" do
        player.selection

        expect(display.messages.length).to eq(5)
      end

      it "returns the player's chosen space" do
        expect(player.selection).to eq(5)
      end
    end
  end
end
