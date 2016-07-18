class Piece
  STRAIGHTS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONALS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
  KNIGHTS = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]

  MOVES = {
    rook: STRAIGHTS,
    bishop: DIAGONALS,
    queen: STRAIGHTS + DIAGONALS,
    king: STRAIGHTS + DIAGONALS,
    knight: KNIGHTS,
    pawn: [[1, 0], [1, 1], [1, -1]]
  }

  attr_reader :board, :color, :name
  attr_accessor :pos

  def initialize(pos, board, color, name)
    @pos = pos
    @board = board
    @color = color
    @name = name
  end

  def add_array(arr1, arr2)
    [arr1.first + arr2.first, arr1.last + arr2.last]
  end

  def valid_move?(pos, color)
  end
end

class SlidingPiece < Piece

  def initialize
    super
  end

  def multiplier(arr, number)
    arr.map { |el| el * number }
  end

  def moves
    result = []
    MOVES[name].each do |move|
      (1..7).each do |idx|
        new_pos = add_array(pos, multiplier(move,idx))
        valid_move?(new_pos, color) ? result << new_pos : break
      end
    end
    result
  end

end

class SteppingPiece < Piece
  def initialize
    super
  end

  def moves
    result = []
    MOVES[name].each do |move|
      new_pos = add_array(pos, move)
      result << move if valid_move?(new_pos, color)
    end
    result
  end

end

class Pawn < Piece
  def initialize
    super
    @name = :pawn
    @moved = false
    @multiplier = (@color == :white ? -1 : 1)
  end

  def moves
    result = []
    unless @moved
      
    end
  end

end

class NullPiece < Piece
  def initialize
  end
end
