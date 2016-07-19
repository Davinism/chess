require_relative "board"
require_relative "player"
require "display"

class Game
  attr_reader :board
  attr_accessor :current_player, :previous_player

  def initialize(board, player1, player2)
    @board = board
    @current_player = player1
    @previous_player = player2
  end

  def play
    until won?
      @current_player.play_turn
      switch_players
    end
  end

  def switch_players
    @current_player, @previous_player = @previous_player, @current_player
  end

  def won?
    @board.checkmate?
  end
end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  b.make_starting_grid
  p1 = Player.new("Davin", :white)
  p2 = Player.new("Kelly", :black)
  g = Game.new(b, p1, p2)
  d = Display.new(b, g)
  while true
    system("clear")
    8.times do
      puts
    end
    d.render
    d.get_input
  end
end
