require_relative "./display"
require_relative "./presenter"
require_relative "./board"
require_relative "./player"

class TicTacToe
  attr_reader :presenter, :display, :board, :player

  def initialize(presenter, display, board, player)
    @presenter = presenter
    @display = display
    @board = board
    @player = player
  end

  def run
    show_board
    play_game
  end

  private

  def show_board
    display.output(presenter.present(board))
  end

  def play_turn
    position = player.selection(board)
    board.place_token(position)
  end

  def play_game
    while board.in_progress?
      play_turn
      show_board
    end
  end
end

if $PROGRAM_NAME == __FILE__
  display = Display.new($stdout, $stdin)
  presenter = TextPresenter.new
  board = Board.new
  player = Player.new(display)
  TicTacToe.new(presenter, display, board, player).run
end
