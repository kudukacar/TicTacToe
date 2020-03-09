require "spec_helper"
require "game"

RSpec.describe Board do
  subject(:board) { Board.new }
  let(:x) { "X" }
  let(:o) { "O" }

  describe "#place_token" do
    it "places the player's token on the board corresponding to the chosen space" do
      board.place_token(4, x)

      expect(board.get(4)).to eq(x)
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
        board.place_token(1, x)

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
    [1, 3].each { |position| board.place_token(position, x) }
    board.place_token(2, O)
  end

  def set_draw
    [1, 3, 6, 7, 8].each { |position| board.place_token(position, x) }
    [2, 4, 5, 9].each { |position| board.place_token(position, o) }
  end

  describe "#outcome" do
    def set_diagonal_winner
      [1, 3, 5, 8, 9].each { |position| board.place_token(position, x) }
      [2, 4, 6, 7].each { |position| board.place_token(position, o) }
    end

    def set_column_winner
      [1, 4, 7].each { |position| board.place_token(position, x) }
      [2, 3].each { |position| board.place_token(position, o) }
    end

    def set_row_winner
      [1, 2, 3].each { |position| board.place_token(position, x) }
      [4, 7].each { |position| board.place_token(position, o) }
    end

    context "with a diagonal winner" do
      it "returns an object with a status of win and the diagonal winner" do
        set_diagonal_winner
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :win, winner: x)
      end
    end

    context "with a column winner" do
      it "returns an object with a status of win and the column winner" do
        set_column_winner
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :win, winner: x)
      end
    end

    context "with a row winner" do
      it "returns an object with a status of win and the row winner" do
        set_row_winner
        outcome = board.outcome

        expect(outcome).to have_attributes(status: :win, winner: x)
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
end
