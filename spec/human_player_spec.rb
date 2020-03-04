require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe HumanPlayer do
  subject(:player) { HumanPlayer.new(display: display, token: token, validator: validator, parse_input: parse_input) }
  let(:token) { "X" }

  class DisplayWithOnlyOutput
    attr_reader :messages, :input

    def initialize
      @messages = []
    end

    def output(message)
      @messages << message
      nil
    end
  end

  class FakeParseInput
    attr_reader :inputs

    def initialize(inputs: [])
      @inputs = inputs
    end

    def input_to_integer
      inputs.shift.to_i
    end
  end

  class BoardWithNoMethods end

  class ValidatorWithoutOneAvailable
    def validate_board_position(selection, board)
      return "Invalid entry." if selection == 0
      return "Selection taken" if selection == 1
      selection
    end
  end

  describe "#selection" do
    context "with a valid entry between 1 and 9" do
      let(:display) { DisplayWithOnlyOutput.new }
      let(:validator) { ValidatorWithoutOneAvailable.new }
      let(:board) { BoardWithNoMethods.new }
      let(:parse_input) { FakeParseInput.new(inputs: ["5"]) }

      it "prompts the next player for a move" do
        player.selection(board)

        expect(display.messages).to include(/Go X/, /Please select your move/)
      end

      it "returns the player's chosen space" do
        expect(player.selection(board)).to eq(5)
      end
    end

    context "with an invalid entry" do
      let(:display) { DisplayWithOnlyOutput.new }
      let(:validator) { ValidatorWithoutOneAvailable.new }
      let(:board) { BoardWithNoMethods.new }
      let(:parse_input) { FakeParseInput.new(inputs: ["0", "?", "5"]) }

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
      let(:display) { DisplayWithOnlyOutput.new }
      let(:validator) { ValidatorWithoutOneAvailable.new }
      let(:board) { BoardWithNoMethods.new }
      let(:parse_input) { FakeParseInput.new(inputs: ["1", "1", "5"]) }

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
