require "spec_helper"
require "tictactoe"

RSpec.describe HumanPlayer do
  subject(:player) { HumanPlayer.new(display, token) }
  let(:token) { "X" }

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

  class HumanPlayer::FakeBoard
    attr_reader :selection

    def initialize
      @selection = 1
    end

    def is_available?(position)
      (1..9).cover?(position) unless position == selection
    end
  end

  describe "#selection" do
    context "with a valid entry between 1 and 9" do
      let(:display) { FakeDisplay.new(inputs: ["5"]) }
      let(:board) { HumanPlayer::FakeBoard.new }

      it "prompts the next player for a move" do
        player.selection(board)

        expect(display.messages).to include(/Go X/, /Please select your move/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an invalid entry" do
      let(:display) { FakeDisplay.new(inputs: ["0", "?", "5"]) }
      let(:board) { HumanPlayer::FakeBoard.new }
      it "prompts the next player for a move until receiving a valid move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Go X/, /Please select/, /Invalid entry./, \
          /Please select/, /Invalid entry./, /Please select/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an unavailable entry" do
      let(:display) { FakeDisplay.new(inputs: ["1", "1", "5"]) }
      let(:board) { HumanPlayer::FakeBoard.new }

      it "prompts the next player for a move until receiving an available move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Go X/, /Please select/, /Selection taken/, \
          /Please select/, /Selection taken/, /Please select/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end
  end
end
