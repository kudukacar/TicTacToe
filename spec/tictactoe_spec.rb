require "spec_helper"
require "tictactoe"
require "ostruct"

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
    def present(board)
      (1..9).map { |i| board.get(i) || "-" }.join("")
    end
  end

  class FakePlayer
    def selection(board)
    end
  end

  class TicTacToe::FakeBoard
    attr_reader :grid

    def initialize
      @grid = []
    end

    def place_token(position)
      grid.push("X")
    end

    def get(position)
      grid[position - 1]
    end

    def outcome
      return OpenStruct.new(status: :draw, winner: nil) if grid.length > 6
      OpenStruct.new(status: :in_progress, winner: nil)
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
        "XX-------",
        "XXX------",
        "XXXX-----",
        "XXXXX----",
        "XXXXXX---",
        "XXXXXXX--",
      ]

      tictactoe.run

      expect(display.messages).to eq(expected_boards)
    end
  end
end
