class Presenter
  def display_board(board)
    blank_space = " "
    <<~BOARD

       #{board[0] || blank_space} | #{board[1] || blank_space} | #{board[2] || blank_space}
      ---+---+---
       #{board[3] || blank_space} | #{board[4] || blank_space} | #{board[5] || blank_space}
      ---+---+---
       #{board[6] || blank_space} | #{board[7] || blank_space} | #{board[8] || blank_space}

    BOARD
  end
end
