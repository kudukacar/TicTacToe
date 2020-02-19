class Presenter
  def display_board(board)
    <<~BOARD

       #{display_cell(1, board)} | #{display_cell(2, board)} | #{display_cell(3, board)}
      ---+---+---
       #{display_cell(4, board)} | #{display_cell(5, board)} | #{display_cell(6, board)}
      ---+---+---
       #{display_cell(7, board)} | #{display_cell(8, board)} | #{display_cell(9, board)}

    BOARD
  end

  private

  def display_cell(pos, board)
    board.get(pos) || " "
  end
end
