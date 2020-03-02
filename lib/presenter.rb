class TextPresenter
  ERROR_MESSAGES = {
    invalid_entry: "Invalid entry.",
    space_taken: "Selection taken and not available.",
  }

  def present(board)
    displayed_board = <<~BOARD

       #{display_cell(1, board)} | #{display_cell(2, board)} | #{display_cell(3, board)}
      ---+---+---
       #{display_cell(4, board)} | #{display_cell(5, board)} | #{display_cell(6, board)}
      ---+---+---
       #{display_cell(7, board)} | #{display_cell(8, board)} | #{display_cell(9, board)}

    BOARD
    displayed_board + display_outcome(board)
  end

  def prompt_player(player)
    "Go #{player}"
  end

  def select_position
    "Please select your move by entering the number (1 - 9, from top left to bottom right) of an empty space."
  end

  def show_error(error)
    ERROR_MESSAGES[error]
  end

  private

  def display_cell(position, board)
    board.get(position) || " "
  end

  def display_outcome(board)
    outcome = board.outcome
    return "#{outcome.winner} wins!" if outcome.status == :win
    return "Draw 😕" if outcome.status == :draw
    ""
  end
end
