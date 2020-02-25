require "spec_helper"
require "tictactoe"

RSpec.describe Presenter do
  subject(:presenter) { Presenter.new }

  class Presenter::FakeBoard
    def initialize
      @board = Array.new(9)
    end

    def place_token(position)
      @board[position - 1] = "X"
    end

    def get(position)
      @board[position - 1]
    end
  end

  describe "#board" do
    it "formats the board" do
      board = Presenter::FakeBoard.new
      board.place_token(5)
      blank_string = " "
      expected_board = <<~BOARD

           |   | #{blank_string}
        ---+---+---
           | X | #{blank_string}
        ---+---+---
           |   | #{blank_string}

      BOARD

      expect(presenter.board(board)).to eq(expected_board)
    end
  end

  describe "#draw_outcome" do
    it "formats the draw outcome message" do
      expected_draw_message = "Draw"

      expect(presenter.draw_outcome).to include(expected_draw_message)
    end
  end

  describe "#win_outcome" do
    it "formats the win outcome message" do
      expected_win_message = "win"
      token = "X"

      expect(presenter.win_outcome(token)).to include(expected_win_message)
    end
  end
end
