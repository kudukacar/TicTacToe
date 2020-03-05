require "spec_helper"
require "game"

RSpec.describe ComputerPlayer do
  class BoardWithFourAvailable
    def is_available?(selection)
      return selection if selection == 4
    end
  end

  describe "#selection" do
    it "returns a selection available on the board" do
      board = BoardWithFourAvailable.new
      player = ComputerPlayer.new(token: "O", board: board)

      expect(player.selection).to eq(4)
    end
  end
end
