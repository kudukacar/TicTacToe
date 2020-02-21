require_relative "./display"
require_relative "./presenter"
require_relative "./board"
require_relative "./player"

class TicTacToe
  def initialize(presenter, display, board, player)
    @presenter = presenter
    @display = display
    @board = board
    @player = player
  end

  def run
    show_board
    play_turn
    show_board
    play_turn
    show_board
  end

  private

  def show_board
    @display.output(@presenter.display_board(@board))
  end

  def play_turn
    position = @player.selection(@board)
    @board.place_token(position, @board.next_token)
  end
end

if $PROGRAM_NAME == __FILE__
  display = Display.new($stdout, $stdin)
  presenter = Presenter.new
  board = Board.new
  player = Player.new(display)
  TicTacToe.new(presenter, display, board, player).run
end
