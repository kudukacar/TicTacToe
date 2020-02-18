require "spec_helper"
require "tictactoe"

RSpec.describe "TicTacToe" do
  class FakeDisplay
    attr_reader :lines
    def initialize
      @lines = []
    end

    def output(message)
      @lines << message
      nil
    end
  end

  class FakePresenter
    def display_board
      "displayed_board"
    end
  end

  describe "#run" do
    it "prints an empty 3 x 3 Tic-Tac-Toe board" do
      display = FakeDisplay.new
      presenter = FakePresenter.new
      tictactoe = TicTacToe.new(presenter, display)
      expected_message = "displayed_board"

      tictactoe.run

      expect(display.lines).to eq([expected_message])
    end
  end
end
