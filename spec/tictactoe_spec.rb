require "spec_helper"
require "tictactoe"

RSpec.describe TicTacToe do
  class TicTacToe::FakeDisplay
    attr_reader :messages

    def initialize
      @messages = []
    end

    def output(message)
      @messages << message
      nil
    end

    def input
      :not_used
    end
  end

  class FakePresenter
    def display_board(board)
      (1..9).map { |i| board.get(i) || "-" }.join("")
    end
  end

  class FakePlayer
    def initialize
      @inputs = [1, 2]
    end

    def selection(board)
      @inputs.shift
    end
  end

  describe "#run" do
    it "shows every state of the board" do
      display = TicTacToe::FakeDisplay.new
      presenter = FakePresenter.new
      board = Board.new
      player = FakePlayer.new
      tictactoe = TicTacToe.new(presenter, display, board, player)
      expected_boards = ["---------", "X--------", "XO-------"]

      tictactoe.run

      expect(display.messages).to eq(expected_boards)
    end
  end
end
