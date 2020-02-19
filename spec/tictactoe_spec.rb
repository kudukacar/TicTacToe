require "spec_helper"
require "tictactoe"

RSpec.describe TicTacToe do
  subject(:tictactoe) { TicTacToe.new(presenter, display, board, player) }

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
    def move
      2
    end
  end

  describe "#show_board" do
    let(:display) { TicTacToe::FakeDisplay.new }
    let(:presenter) { FakePresenter.new }
    let(:board) { FakeBoard.new }
    let(:player) { FakePlayer.new }

    describe "#show_board" do
      context "before a move" do
        it "shows an empty 3 x 3 Tic-Tac_Toe board" do
          expected_message = "displayed_board"

          tictactoe.show_board

          expect(display.lines).to eq([expected_message])
        end
      end

      context "after a move" do
        it "shows the current state of the 3 x 3 Tic-Tac-Toe board" do
          expected_message = "displayed_boardX"

          tictactoe.play_turn
          tictactoe.show_board

          expect(display.lines).to eq([expected_message])
        end
      end
    end

    describe "#play_turn" do
      it "records the player's move" do
        tictactoe.play_turn

        expect(board[1]).to eq("X")
      end
    end
  end
end
