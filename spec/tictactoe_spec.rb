require "spec_helper"
require "tictactoe"

RSpec.describe TicTacToe do
  class TicTacToe::FakeDisplay
    attr_reader :lines

    def initialize
      @lines = []
    end

    def output(message)
      @lines << message
      nil
    end

    def input
      :not_used
    end
  end

  class FakePresenter
    def display_board(board)
      "#{board[0]}displayed_board#{board[1]}"
    end
  end

  class FakeBoard
    def initialize
      @board = [nil, nil]
    end

    def place_token(pos, token)
      @board[pos] = token
    end

    def[](pos)
      @board[pos]
    end
  end

  class FakePlayer
    def selection
      1
    end
  end

  describe "#run" do
    display = TicTacToe::FakeDisplay.new
    presenter = FakePresenter.new
    board = FakeBoard.new
    player = FakePlayer.new
    tictactoe = TicTacToe.new(presenter, display, board, player)

    tictactoe.run

    context "before a move" do
      it "shows an empty 3 x 3 Tic-Tac_Toe board" do
        expected_message = "displayed_board"
        expect(display.lines[0]).to eq(expected_message)
      end
    end

    context "after a move" do
      it "records the player's move" do
        expect(board[1]).to eq("X")
      end

      it "shows the current state of the 3 x 3 Tic-Tac-Toe board" do
        expected_message = "displayed_boardX"
        expect(display.lines[1]).to eq(expected_message)
      end
    end
  end
end
