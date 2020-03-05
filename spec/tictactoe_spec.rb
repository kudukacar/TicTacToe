require "spec_helper"
require "game"
require "ostruct"

RSpec.describe TicTacToe do
  X = "X"
  O = "O"

  class FakeDisplay
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

    def selection
      @moves.shift
    end
  end

  class BoardWithOutcomes
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

    def outcome
      return OpenStruct.new(status: :win, winner: X) if grid.length > 6
      OpenStruct.new(status: :in_progress, winner: nil)
    end
  end

  describe "#run" do
    it "plays the game until an outcome" do
      display = FakeDisplay.new
      presenter = FakePresenter.new
      board = BoardWithOutcomes.new
      player = FakePlayer.new(moves: [1, 3, 5, 7], token: X)
      other_player = FakePlayer.new(moves: [2, 4, 6], token: O)
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
      display = FakeDisplay.new(input: ["1", "2", "3", "4", "5", "6", "7"])
      presenter = TextPresenter.new
      board = Board.new
      validator = PositionValidator.new(board)
      parse_input = ParseInput.new
      user = User.new(display)
      player = HumanPlayer.new(user: user, token: X, validator: validator, parse_input: parse_input)
      other_player = HumanPlayer.new(user: user, token: O, validator: validator, parse_input: parse_input)
      players = [player, other_player]
      TicTacToe.new(presenter, display, board, players).run

      expect(display.messages).to include(/X wins/)
    end
  end
end
