require "spec_helper"
require "tictactoe"

RSpec.describe Board do
  describe "#place_token" do
    it "places the player's token on the board corresponding to the chosen space" do
      board = Board.new

      board.place_token(4, "X")

      expect(board[4]).to eq("X")
    end
  end
end
