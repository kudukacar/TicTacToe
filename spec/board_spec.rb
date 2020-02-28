require "spec_helper"
require "tictactoe"

RSpec.describe Board do
  subject(:board) { Board.new }
  X = "X"
  O = "O"

  describe "#place_token" do
    it "places the player's token on the board corresponding to the chosen space" do
      board.place_token(4, X)

      expect(board.get(4)).to eq(X)
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
        board.place_token(1, X)

        expect(board.is_available?(1)).to eq(false)
      end
    end

    context "when the space on the board is available for a token" do
      it "returns true" do
        expect(board.is_available?(1)).to eq(true)
      end
    end
  end

  def set_no_outcome
    [1, 3].each { |position| board.place_token(position, X) }
    board.place_token(2, O)
  end

  def set_draw
    [1, 3, 6, 7, 8].each { |position| board.place_token(position, X) }
    [2, 4, 5, 9].each { |position| board.place_token(position, O) }
  end

  describe "#outcome" do
    def set_diagonal_winner
      [1, 3, 5, 8, 9].each { |position| board.place_token(position, X) }
      [2, 4, 6, 7].each { |position| board.place_token(position, O) }
    end

    def set_column_winner
      [1, 4, 7].each { |position| board.place_token(position, X) }
      [2, 3].each { |position| board.place_token(position, O) }
    end

    def set_row_winner
      [1, 2, 3].each { |position| board.place_token(position, X) }
      [4, 7].each { |position| board.place_token(position, O) }
    end

    context "with a diagonal winner" do
      it "returns an object with a status of win and the diagonal winner" do
        set_diagonal_winner
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :win, winner: X)
      end
    end

    context "with a column winner" do
      it "returns an object with a status of win and the column winner" do
        set_column_winner
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :win, winner: X)
      end
    end

    context "with a row winner" do
      it "returns an object with a status of win and the row winner" do
        set_row_winner
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :win, winner: X)
      end
    end

    context "with a draw" do
      it "returns an object with a status of draw and a winner of nil" do
        set_draw
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :draw, winner: nil)
      end
    end

    context "with no outcome" do
      it "returns an object with a status of in_progress and winner of nil" do
        set_no_outcome
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :in_progress, winner: nil)
      end
    end
  end

  describe "in_progress?" do
    it "returns true if the game is in_progress" do
      set_no_outcome

      expect(board.in_progress?).to eq(true)
    end

    it "returns false if the game is over" do
      set_draw

      expect(board.in_progress?).to eq(false)
    end
  end
end
