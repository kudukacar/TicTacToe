require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe SelectionValidator do
  subject(:validator) { SelectionValidator.new }

  class BoardWithOneAvailable
    def is_available?(position)
      return 1 if position == 1
    end
  end

  describe "#validate" do
    let(:board) { BoardWithOneAvailable.new }

    context "if the selection is not between 1 and 9" do
      it "returns an object with a status of invalid_entry and a position of nil" do
        selection = 10

        expect(validator.validate(selection, board)).to have_attributes(status: :invalid_entry, position: nil)
      end
    end

    context "if the selection is between 1 and 9 and is available on the board" do
      it "returns an object with the selection" do
        selection = 1

        expect(validator.validate(selection, board)).to have_attributes(position: 1)
      end
    end

    context "if the selection is between 1 and 9 but not available" do
      it "returns an object with a status of :space_taken and a position of nil" do
        selection = 2

        expect(validator.validate(selection, board)).to have_attributes(status: :space_taken, position: nil)
      end
    end
  end
end

RSpec.describe AvailableSpaceValidator do
  class AvailabilityForTwo
    def is_available?(selection)
      return true if selection == 2
    end
  end

  describe "#errors_for" do
    context "when the selection is available" do
      it "has no errors" do
        errors = AvailableSpaceValidator.new(AvailabilityForTwo.new)
          .errors_for(2)

        expect(errors).to be_falsy
      end
    end

    context "when the selection is not available" do
      it "returns an error message" do
        errors = AvailableSpaceValidator.new(AvailabilityForTwo.new)
          .errors_for(1)

        expect(errors).to include("Selection taken")
      end
    end

    it "only validates spaces 1 through 9" do
      validation = AvailableSpaceValidator.new(AvailabilityForTwo.new)

      errors = (0..10).to_a.map do |input|
        validation.errors_for(input)
      end

      expect(errors).to contain_exactly(
        /Invalid/,
        /Selection taken/,
        nil,
        /Selection taken/,
        /Selection taken/,
        /Selection taken/,
        /Selection taken/,
        /Selection taken/,
        /Selection taken/,
        /Selection taken/,
        /Invalid/
      )
    end
  end
end
