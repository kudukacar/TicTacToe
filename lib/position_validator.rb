class PositionValidator
  attr_reader :board

  ERROR_MESSAGES = {
    invalid_entry: "Invalid entry.",
    space_taken: "Selection taken and not available.",
  }

  def initialize(board)
    @board = board
  end

  def error(selection)
    return ERROR_MESSAGES[:invalid_entry] unless selection.between?(1, 9)
    return ERROR_MESSAGES[:space_taken] unless board.is_available?(selection)
  end
end
