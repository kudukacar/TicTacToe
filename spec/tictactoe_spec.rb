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
    attr_reader :token

    def initialize(moves:, token:)
      @moves = moves
      @token = token
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

    def place_token(position, token)
      grid.push(token)
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
      player = FakePlayer.new(moves: [1, 3, 5, 7], token: "X")
      other_player = FakePlayer.new(moves: [2, 4, 6], token: "O")
      players = [player, other_player]

      TicTacToe.new(presenter, display, board, players).run

      expected_boards = [
        "---------",
        "X--------",
        "XO-------",
        "XOX------",
        "XOXO-----",
        "XOXOX----",
        "XOXOXO---",
        "XOXOXOX--",
      ]

      expect(display.messages).to eq(expected_boards)
    end
  end

  describe "integration" do
    it "ends with X winning the game" do
      display = TicTacToe::FakeDisplay.new(input: ["1", "2", "3", "4", "5", "6", "7"])
      presenter = TextPresenter.new
      board = Board.new
      player = HumanPlayer.new(display, "X")
      other_player = HumanPlayer.new(display, "O")
      players = [player, other_player]

      TicTacToe.new(presenter, display, board, players).run

      expect(display.messages).to include(/X wins/)
    end
  end
end
