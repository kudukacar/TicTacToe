require "spec_helper"
require "tictactoe"
require "presenter"
require "fake_standard_out"

RSpec.describe "TicTacToe" do
  describe "#run" do
    it "prints an empty 3 x 3 Tic-Tac-Toe board" do
      stdout = FakeStandardOut.new
      display = Display.new(stdout)
      presenter = Presenter.new
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
