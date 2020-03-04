require "spec_helper"
require "tictactoe"

RSpec.describe ComputerPlayer do
  class BoardWithFourAvailable
    def is_available?(selection)
      return selection if selection == 4
    end
  end

  describe "#selection" do
    it "returns a selection available on the board" do
      player = ComputerPlayer.new(token: "O")
      board = BoardWithFourAvailable.new

      expect(player.selection(board)).to eq(4)
    end
  end
end
