require "spec_helper"
require "tictactoe"
require "presenter"
require "fake_standard_out"

RSpec.describe "TicTacToe" do
  class FakePresenter
    def display_board
      <<~BOARD
          |  |
        --+--+--
          |  |
        --+--+--
          |  |
      BOARD
    end
  end
  class FakeDisplay
    def initialize(stdout)
      @stdout = stdout
    end

    def output(message)
      @stdout.puts message
    end
  end
  describe "#run" do
    it "prints an empty 3 x 3 Tic-Tac-Toe board" do
      stdout = FakeStandardOut.new
      display = FakeDisplay.new(stdout)
      presenter = FakePresenter.new
      tictactoe = TicTacToe.new(presenter, display)
      expected_board = <<~BOARD
          |  |
        --+--+--
          |  |
        --+--+--
          |  |
      BOARD

      tictactoe.run

      expect(stdout.log).to eq(expected_board)
    end
  end
end
