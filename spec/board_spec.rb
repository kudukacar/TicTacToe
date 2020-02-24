require "spec_helper"
require "tictactoe"

RSpec.describe Board do
  subject(:board) { Board.new }
  let(:token) { "X" }

  describe "#place_token" do
    it "places the player's token on the board corresponding to the chosen space" do
      board.place_token(4)

      expect(board.get(4)).to eq(token)
    end
  end

  describe "is_available?" do
    context "when the space on the board is not available for a token" do
      it "returns false" do
        board.place_token(1)

        expect(board.is_available?(1)).to eq(false)
      end
    end

    context "when the space on the board is available for a token" do
      it "returns true" do
        expect(board.is_available?(1)).to eq(true)
      end
    end
  end

  describe "#game_over?" do
    def fill_board
      [1, 2, 3, 4, 6, 5, 7, 9, 8].each { |pos| board.place_token(pos) }
    end

    def set_diagonal_winner
      (1..7).each { |pos| board.place_token(pos) }
    end

    def set_column_winner
      [1, 2, 4, 3, 7].each { |pos| board.place_token(pos) }
    end

    def set_row_winner
      [1, 4, 2, 7, 3].each { |pos| board.place_token(pos) }
    end

    context "with a diagonal winner" do
      it "returns true" do
        set_diagonal_winner

        expect(board.game_over?).to eq(true)
      end
    end

    context "with a column winner" do
      it "returns true" do
        set_column_winner

        expect(board.game_over?).to eq(true)
      end
    end

    context "with a row winner" do
      it "returns true" do
        set_row_winner

        expect(board.game_over?).to eq(true)
      end
    end

    context "with a tie" do
      it "returns true" do
        fill_board

        expect(board.game_over?).to eq(true)
      end
    end
  end
end
