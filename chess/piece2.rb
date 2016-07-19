class Piece

  attr_reader :board, :color
  attr_accessor :pos

  def initialize(pos, board, color, name)
    @pos = pos
    @board = board
    @color = color
  end

  def to_s
    
  end

  def empty?

  end

  def symbol

  end

  def valid_move?(pos, color)
  end

  def move_into_check?(to_pos)

  end
end

class SlidingPiece < Piece

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
  attr_reader :multiplier

  def initialize
    super
    @name = :pawn
    @moved = false
    @multiplier = (@color == :white ? -1 : 1)
  end

  def moves
    result = []
    unless @moved
      forward_moves = [[1, 0], [2, 0]].map { |move| move.map { |el| el * multiplier } }
      possible_moves = forward_moves.select do |move|
        valid_move?(add_array(move, pos), color)
      end
      result.concat(possible_moves)
    else
      forward_move = [1, 0].map { |el| el * multiplier }
      new_pos = add_array(forward_move, pos)

      result.concat(forward_move) if valid_move?(new_pos, color)
    end
    diagonal_moves = [[1, -1], [1, 1]].map { |move| move.map { |el| el * multiplier } }
    possible_moves = diagonal_moves.select do |move|
      valid_move?(add_array(move, pos), color)
    end
    result.concat(possible_moves)
  end
end

class NullPiece
  include Singleton

  def moves
  end

  def add_array(arr1, arr2)
  end

  def valid_move?(pos, color)
  end

  attr_reader :board, :color, :name
  attr_accessor :pos

end
