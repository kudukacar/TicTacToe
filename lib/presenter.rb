class TextPresenter
  def present(board, game)
    displayed_board = <<~BOARD

       #{display_cell(1, board)} | #{display_cell(2, board)} | #{display_cell(3, board)}
      ---+---+---
       #{display_cell(4, board)} | #{display_cell(5, board)} | #{display_cell(6, board)}
      ---+---+---
       #{display_cell(7, board)} | #{display_cell(8, board)} | #{display_cell(9, board)}

    BOARD
    displayed_board + display_outcome(board, game)
  end

  private

  def display_cell(position, board)
    board.get(position) || " "
  end

  def display_outcome(board, game)
    outcome = game.outcome(board)
    return "#{outcome.winner} wins!" if outcome.status == :win
    return "Draw 😕" if outcome.status == :draw
    ""
  end
end
