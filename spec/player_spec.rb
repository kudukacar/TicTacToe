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

  class Player::FakeBoard
    attr_reader :grid

    def initialize(grid)
      @grid = grid
    end

    def is_available?(position)
      ![1].include?(position)
    end
  end

  describe "#selection" do
    context "with a valid entry between 1 and 9" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["5"]) }
      let(:board) { Player::FakeBoard.new([]) }

      it "prompts the player for a move" do
        player.selection(board)

        expect(display.messages).to include(/Please select your move/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an invalid entry" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["0", "?", "5"]) }
      let(:board) { Player::FakeBoard.new([]) }
      it "prompts the player for a move until receiving a valid move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Please select/, /Invalid entry./, \
          /Please select/, /Invalid entry./, /Please select/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an unavailable entry" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["1", "1", "5"]) }
      let(:board) { Player::FakeBoard.new(["X"]) }

      it "prompts the player for a move until receiving an available move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Please select/, /Selection taken/, \
          /Please select/, /Selection taken/, /Please select/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end
  end
end
