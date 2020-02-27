require_relative "./display"
require_relative "./presenter"
require_relative "./board"
require_relative "./player"
require_relative "./game"

class TicTacToe
  attr_reader :presenter, :display, :board, :player, :game

  def initialize(presenter, display, board, player, game)
    @presenter = presenter
    @display = display
    @board = board
    @player = player
    @game = game
  end

  def run
    show_board
    play_game
  end

  private

  def show_board
    display.output(presenter.present(board, game))
  end

  def play_turn
    position = player.selection(board)
    board.place_token(position)
  end

  def play_game
    while game.outcome(board).status == :in_progress
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
  game = Game.new
  TicTacToe.new(presenter, display, board, player, game).run
end
