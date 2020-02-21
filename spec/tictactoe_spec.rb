require "spec_helper"
require "tictactoe"
require "fake_display"

RSpec.describe TicTacToe do
  class FakePresenter
    def display_board(board)
      (1..9).map { |i| board.get(i) || "-" }.join("")
    end
  end

  class FakePlayer
    def initialize(display)
      @display = display
    end

    def selection(board)
      @display.input
    end
  end

  describe "#run" do
    it "shows every state of the board" do
      display = FakeDisplay.new(inputs: [1, 2])
      presenter = FakePresenter.new
      board = Board.new
      player = FakePlayer.new(display)
      tictactoe = TicTacToe.new(presenter, display, board, player)
      expected_boards = ["---------", "X--------", "XO-------"]

      tictactoe.run

      expect(display.messages).to eq(expected_boards)
    end
  end
end
