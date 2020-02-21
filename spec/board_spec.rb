require "spec_helper"
require "tictactoe"

RSpec.describe Board do
  subject(:board) { Board.new }

  describe "#place_token" do
    it "places the player's token on the board corresponding to the chosen space" do
      board.place_token(4, "X")

      expect(board.get(4)).to eq("X")
    end
  end

  describe "#next_token" do
    it "determines the next token to be placed on the board" do
      expect(board.next_token).to eq("X")
    end
  end

  describe "is_available?" do
    context "when the space on the board is not available for a token" do
      it "returns false" do
        board.place_token(1, "X")

        expect(board.is_available?(1)).to eq(false)
      end
    end

    context "when the space on the board is available for a token" do
      it "returns true" do
        expect(board.is_available?(1)).to eq(true)
      end
    end
  end
end
