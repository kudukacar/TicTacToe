require "spec_helper"
require "tictactoe"

RSpec.describe Presenter do
  describe "#display_board" do
    it "formats the board" do
      presenter = Presenter.new
      board = Board.new
      board.place_token(5)
      blank_string = " "
      expected_board = <<~BOARD

           |   | #{blank_string}
        ---+---+---
           | X | #{blank_string}
        ---+---+---
           |   | #{blank_string}

      BOARD

      expect(presenter.display_board(board)).to eq(expected_board)
    end
  end
end
