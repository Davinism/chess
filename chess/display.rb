require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  include Cursorable

  def initialize(board, game)
    @board = board
    @game = game
    @cursor_pos = [0,0]
  end

  def render
    @board.grid.each_with_index do |row, idx|
      print " ".center(28)
      row.each_index do |jdx|
        if [idx, jdx] == @cursor_pos
          print "   ".colorize(:background => :red)
        elsif (idx + jdx).even?
          print "   ".colorize(:background => :white)
        else
          print "   ".colorize(:background => :black)
        end
      end
      puts
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b, "game")

  while true
    system("clear")
    8.times do
      puts
    end
    d.render
    d.get_input
  end
end
