require "colorize"
require_relative "cursorable"
require_relative "board"
require_relative "game"

class Display
  include Cursorable

  def initialize(board, game)
    @board = board
    @game = game
    @cursor_pos = [0,0]
    @selected = false
    @selected_pos = nil
  end

  def render
    @board.grid.each_with_index do |row, idx|
      print " ".center(28)
      row.each_index do |jdx|
        if [idx, jdx] == @cursor_pos
          print " #{@board[idx, jdx].to_s} ".colorize(:background => :red)
        elsif @selected && @board[*@selected_pos].moves.include?([idx, jdx])
          print " #{@board[idx, jdx].to_s} ".colorize(:background => :yellow)
        elsif (idx + jdx).even?
          print " #{@board[idx, jdx].to_s} ".colorize(:background => :light_blue)
        else
          print " #{@board[idx, jdx].to_s} ".colorize(:background => :gray)
        end
      end
      puts
    end
  end
end
