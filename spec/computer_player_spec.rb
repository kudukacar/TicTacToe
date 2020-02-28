require "spec_helper"
require "tictactoe"

RSpec.describe ComputerPlayer do
  class ComputerPlayer::FakeBoard
    def is_available?(position)
      return true if position == 4
      false
    end
  end

  describe "#selection" do
    it "returns a selection available on the board" do
      player = ComputerPlayer.new("O")
      board = ComputerPlayer::FakeBoard.new

      expect(player.selection(board)).to eq(4)
    end
  end
end
