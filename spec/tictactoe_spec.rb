require 'spec_helper'
require 'tictactoe'

RSpec.describe "TicTacToe" do
  describe "#run" do
    it "returns true" do
      tictactoe = TicTacToe.new
      expect(tictactoe.run).to eql true
    end
  end
end