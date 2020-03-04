require "ostruct"

class SelectionValidator
  def validate(selection, board)
    return OpenStruct.new(status: :invalid_entry, position: nil) unless selection.between?(1, 9)
    return OpenStruct.new(status: :space_taken, position: nil) unless board.is_available?(selection)
    OpenStruct.new(position: selection)
  end
end

class AvailableSpaceValidator
  def initialize(availability)
    @availability = availability
  end

  def errors_for(position)
    return "Invalid" unless position.between?(1, 9)
    return "Selection taken and not available" unless availability.is_available?(position)
  end

  private
  attr_reader :availability
end
