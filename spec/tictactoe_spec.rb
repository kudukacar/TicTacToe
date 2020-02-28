require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe TicTacToe do
  class TicTacToe::FakeDisplay
    attr_reader :messages, :input

    def initialize(input: [])
      @messages = []
      @input = input
    end

    def output(message)
      @messages << message
      nil
    end

    def input
      @input.shift
    end
  end

  class FakePresenter
    def present(board)
      (1..9).map { |i| board.get(i) || "-" }.join("")
    end
  end

  class FakePlayer
    def initialize(moves:)
      @moves = moves
    end

    def selection(board)
      @moves.shift
    end
  end

  class TicTacToe::FakeBoard
    attr_reader :grid

    def initialize
      @grid = []
    end

    def place_token(position)
      grid.push(position)
    end

    def get(position)
      grid[position - 1]
    end

    def in_progress?
      return true if grid.length <= 6
      false
    end
  end

  describe "#run" do
    it "plays the game until an outcome" do
      display = TicTacToe::FakeDisplay.new
      presenter = FakePresenter.new
      board = TicTacToe::FakeBoard.new
      player = FakePlayer.new(moves: (1..7).to_a)

      TicTacToe.new(presenter, display, board, player).run

      expected_boards = [
        "---------",
        "1--------",
        "12-------",
        "123------",
        "1234-----",
        "12345----",
        "123456---",
        "1234567--",
      ]

      expect(display.messages).to eq(expected_boards)
    end
  end

  describe "integration" do
    it "ends with X winning the game" do
      display = TicTacToe::FakeDisplay.new(input: ["1", "2", "3", "4", "5", "6", "7"])
      presenter = TextPresenter.new
      board = Board.new
      player = Player.new(display)

      TicTacToe.new(presenter, display, board, player).run
      
      expect(display.messages).to include(/X wins/)
    end
  end
end
