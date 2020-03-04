class SelectionValidator
  ERROR_MESSAGES = {
    invalid_entry: "Invalid entry.",
    space_taken: "Selection taken and not available.",
  }

  def validate_board_position(selection, board)
    return ERROR_MESSAGES[:invalid_entry] unless selection.between?(1, 9)
    return ERROR_MESSAGES[:space_taken] unless board.is_available?(selection)
    selection
  end

  def validate_game_option(selection, options_count)
    return ERROR_MESSAGES[:invalid_entry] unless selection.between?(1, options_count)
    selection
  end
end