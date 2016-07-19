require_relative "piece.rb"
require "byebug"

class Board
  attr_reader :grid

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8) }
    set_up_black_specials
    set_up_white_specials
    set_up_black_pawns
    set_up_white_pawns
    set_up_nulls
  end

  def initialize(grid = Array.new(8) { Array.new(8) })
    @grid = grid
  end

  def move(start, end_pos)
    prc = proc { |el| el.between?(0,7) }
    if !(start.all? { |el| prc.call(el)} && end_pos.all? { |el| prc.call(el) })
      raise ArgumentError.new "Out of bounds. Invalid move!"
    elsif self[*start] == nil || self[*end_pos] != nil
      raise ArgumentError.new "Invalid move!"
    end
    self[*end_pos] = self[*start]
    self[*start] = nil
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, piece)
    @grid[row][col] = piece
  end

  def in_bounds?(pos)
    x, y = pos
    prc = proc { |el| el.between?(0,7) }
    prc.call(x) && prc.call(y)
  end

  private
  def set_up_black_specials
    self[0, 0] = Piece.new([0, 0], self, :black, :rook)
    self[0, 7] = Piece.new([0, 7], self, :black, :rook)
    self[0, 1] = Piece.new([0, 1], self, :black, :knight)
    self[0, 6] = Piece.new([0, 6], self, :black, :knight)
    self[0, 2] = Piece.new([0, 2], self, :black, :bishop)
    self[0, 5] = Piece.new([0, 5], self, :black, :bishop)
    self[0, 3] = Piece.new([0, 3], self, :black, :queen)
    self[0, 4] = Piece.new([0, 4], self, :black, :king)
  end

  def set_up_white_specials
    self[7, 0] = Piece.new([7, 0], self, :white, :rook)
    self[7, 7] = Piece.new([7, 7], self, :white, :rook)
    self[7, 1] = Piece.new([7, 1], self, :white, :knight)
    self[7, 6] = Piece.new([7, 6], self, :white, :knight)
    self[7, 2] = Piece.new([7, 2], self, :white, :bishop)
    self[7, 5] = Piece.new([7, 5], self, :white, :bishop)
    self[7, 3] = Piece.new([7, 3], self, :white, :queen)
    self[7, 4] = Piece.new([7, 4], self, :white, :king)
  end

  def set_up_black_pawns
    (0..7).each do |col|
      self[1, col] = Pawn.new([1, col], self, :black, :pawn)
    end
  end

  def set_up_white_pawns
    (0..7).each do |col|
      self[6, col] = Pawn.new([6, col], self, :white, :pawn)
    end
  end

  def set_up_nulls
    (0..7).each do |row|
      (0..7).each do |col|
        self[row, col] = NullPiece.instance if self[row, col].nil?
      end
    end
  end

end
