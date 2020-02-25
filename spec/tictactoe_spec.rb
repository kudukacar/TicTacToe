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
    def board(board)
      (1..9).map { |i| board.get(i) || "-" }.join("")
    end

    def win_outcome(token)
      "---#{token} wins!---"
    end
  end

  class FakePlayer
    def initialize
      @inputs = [1, 2, 3, 4, 5, 6, 7]
    end

    def selection(board)
      @inputs.shift
    end
  end

  class TicTacToe::FakeBoard
    attr_reader :board

    TOKENS = ["X", "O"]

    def initialize
      @board = Array.new(9)
    end

    def place_token(position)
      board[position - 1] = position.odd? ? TOKENS[0] : TOKENS[1]
    end

    def get(position)
      board[position - 1]
    end

    def is_available?(position)
      true
    end

    def outcome
      return "X" if board.count(TOKENS[0]) > 3
    end
  end

  describe "#run" do
    it "plays the game until an outcome" do
      display = TicTacToe::FakeDisplay.new
      presenter = FakePresenter.new
      board = TicTacToe::FakeBoard.new
      player = FakePlayer.new
      tictactoe = TicTacToe.new(presenter, display, board, player)
      expected_boards = [
        "---------",
        "X--------",
        "XO-------",
        "XOX------",
        "XOXO-----",
        "XOXOX----",
        "XOXOXO---",
        "XOXOXOX--",
        "---X wins!---",
      ]

      tictactoe.run

      expect(display.messages).to eq(expected_boards)
    end
  end
end
