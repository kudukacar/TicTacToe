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

  describe "#get" do
    it "gets the value of the given position" do
      expect(board.get(4)).to eq(nil)
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

  describe "#outcome" do
    def set_draw
      [1, 2, 3, 4, 6, 5, 7, 9, 8].each { |position| board.place_token(position) }
    end

    def set_diagonal_winner
      (1..7).each { |position| board.place_token(position) }
    end

    def set_column_winner
      [1, 2, 4, 3, 7].each { |position| board.place_token(position) }
    end

    def set_row_winner
      [1, 4, 2, 7, 3].each { |position| board.place_token(position) }
    end

    def set_no_outcome
      [1, 2, 3].each { |position| board.place_token(position) }
    end

    context "with a diagonal winner" do
      it "returns the diagonal winner" do
        set_diagonal_winner

        expect(board.outcome).to eq(token)
      end
    end

    context "with a column winner" do
      it "returns the column winner" do
        set_column_winner

        expect(board.outcome).to eq(token)
      end
    end

    context "with a row winner" do
      it "returns the row winner" do
        set_row_winner

        expect(board.outcome).to eq(token)
      end
    end

    context "with a draw" do
      it "returns true" do
        set_draw

        expect(board.outcome).to eq(true)
      end
    end

    context "with no outcome" do
      it "returns false" do
        set_no_outcome

        expect(board.outcome).to eq(false)
      end
    end
  end
end
