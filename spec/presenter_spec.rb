require "spec_helper"
require "tictactoe"

RSpec.describe Presenter do
  describe "#display_board" do
    it "formats the board" do
      presenter = Presenter.new
      board = Array.new(9)
      board[4] = "X"
      blank_space = " "
      expected_board = <<~BOARD

         #{board[0] || blank_space} | #{board[1] || blank_space} | #{board[2] || blank_space}
        ---+---+---
         #{board[3] || blank_space} | #{board[4] || blank_space} | #{board[5] || blank_space}
        ---+---+---
         #{board[6] || blank_space} | #{board[7] || blank_space} | #{board[8] || blank_space}

      BOARD

      expect(presenter.display_board(board)).to eq(expected_board)
    end
  end
end
