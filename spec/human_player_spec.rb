require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe HumanPlayer do
  subject(:player) { HumanPlayer.new(display: display, token: token, validator: validator) }
  let(:token) { "X" }

  class FakeDisplay
    attr_reader :messages, :input

    def initialize(input: [])
      @messages = []
      @input = input
    end

    def output(message)
      @messages << message
      nil
    end

    def input
      @input.shift
    end
  end

  class BoardWithNoMethods end

  class ValidatorWithoutOneAvailable
    def validate(selection, board)
      return OpenStruct.new(status: :invalid_entry, position: nil) unless selection.between?(1, 9)
      return OpenStruct.new(status: :space_taken, position: nil) if selection == 1
      OpenStruct.new(position: selection)
    end
  end

  describe "#selection" do
    context "with a valid entry between 1 and 9" do
      let(:display) { FakeDisplay.new(input: ["5"]) }
      let(:validator) { ValidatorWithoutOneAvailable.new }
      let(:board) { BoardWithNoMethods.new }

      it "prompts the next player for a move" do
        player.selection(board)

        expect(display.messages).to include(/Go X/, /Please select your move/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an invalid entry" do
      let(:display) { FakeDisplay.new(input: ["0", "?", "5"]) }
      let(:validator) { ValidatorWithoutOneAvailable.new }
      let(:board) { BoardWithNoMethods.new }

      it "prompts the next player for a move until receiving a valid move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Go X/, /Please select/, /Invalid entry./, \
          /Please select/, /Invalid entry./, /Please select/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an unavailable entry" do
      let(:display) { FakeDisplay.new(input: ["1", "1", "5"]) }
      let(:validator) { ValidatorWithoutOneAvailable.new }
      let(:board) { BoardWithNoMethods.new }

      it "prompts the next player for a move until receiving an available move" do
        player.selection(board)

        expect(display.messages).to contain_exactly(/Go X/, /Please select/, /Selection taken/, \
          /Please select/, /Selection taken/, /Please select/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end
  end
end
