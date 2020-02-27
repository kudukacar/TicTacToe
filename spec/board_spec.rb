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
      [1, 2, 3, 4, 6, 5, 7, 9, 8].each { |pos| board.place_token(pos) }
    end

    def set_diagonal_winner
      [1, 2, 3, 4, 5, 6, 8, 7, 9].each { |position| board.place_token(position) }
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
      it "returns an object with a status of win and the diagonal winner" do
        set_diagonal_winner
        outcome = board.outcome

        expect([outcome.status, outcome.winner]).to contain_exactly(:win, token)
      end
    end

    context "with a column winner" do
      it "returns an object with a status of win and the column winner" do
        set_column_winner
        outcome = board.outcome

        expect([outcome.status, outcome.winner]).to contain_exactly(:win, token)
      end
    end

    context "with a row winner" do
      it "returns an object with a status of win and the row winner" do
        set_row_winner
        outcome = board.outcome

        expect([outcome.status, outcome.winner]).to contain_exactly(:win, token)
      end
    end

    context "with a draw" do
      it "returns an object with a status of draw and a winner of nil" do
        set_draw
        outcome = board.outcome

        expect([outcome.status, outcome.winner]).to contain_exactly(:draw, nil)
      end
    end

    context "with no outcome" do
      it "returns an object with a status of in_progress and winner of nil" do
        set_no_outcome
        outcome = board.outcome

        expect([outcome.status, outcome.winner]).to contain_exactly(:in_progress, nil)
      end
    end
  end
end
