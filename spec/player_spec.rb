require "spec_helper"
require "tictactoe"
require "fake_display"

RSpec.describe Player do
  describe "#selection" do
    context "with a valid entry between 1 and 9" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["5"]) }
      let(:board) { Board.new }

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
      let(:board) { Board.new }
      it "prompts the player for a move until receiving a valid move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Please select your move/, /Invalid entry./, /Please select your move/, /Invalid entry./, /Please select your move/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an unavailable entry" do
      let(:player) { Player.new(display) }
      let(:display) { FakeDisplay.new(inputs: ["1", "1", "5"]) }
      let(:board) { Board.new }

      it "prompts the player for a move until receiving an available move" do
        board.place_token(1, "X")
        player.selection(board)

        expect(display.messages).to contain_exactly(/Please select your move/, /Selection taken/, /Please select your move/, /Selection taken/, /Please select your move/)
      end

      it "returns the player's chosen space" do
        board.place_token(1, "X")
        expect(player.selection(board)).to eq(5)
      end
    end
  end
end
