class TicTacToe
  def run
    puts "Welcome to Tic-Tac-Toe"
    true
  end
end

if $PROGRAM_NAME == __FILE__
  TicTacToe.new.run
end