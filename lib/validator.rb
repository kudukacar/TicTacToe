require 'ostruct'

class SelectionValidator
  def validate(selection, board)
    return OpenStruct.new(status: :invalid_entry, position: nil) unless selection.between?(1, 9)
    return OpenStruct.new(status: :space_taken, position: nil) unless board.is_available?(selection)
    OpenStruct.new(status: :valid, position: selection)
  end
end
