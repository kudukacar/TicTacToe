require "spec_helper"
require "presenter"

RSpec.describe Presenter do
  describe "#display_board" do
    it "formats the board" do
      presenter = Presenter.new
      expected_board = <<~BOARD
          |  |
        --+--+--
          |  |
        --+--+--
          |  |
      BOARD

      expect(presenter.display_board).to eq(expected_board)
    end
  end
end
