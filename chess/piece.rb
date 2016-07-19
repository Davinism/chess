require "singleton"
require "colorize"

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
  }

  WHITE_PRINTABLE = {
    rook: "\u2656",
    bishop: "\u2657",
    queen: "\u2655",
    king: "\u2654",
    knight: "\u2658",
    pawn: "\u2659"
  }

  BLACK_PRINTABLE = {
    rook: "\u265c",
    bishop: "\u265d",
    queen: "\u265b",
    king: "\u265a",
    knight: "\u265e",
    pawn: "\u265f"
  }

  attr_reader :board, :color, :name
  attr_accessor :pos

  def initialize(pos, board, color, name)
    @pos = pos
    @board = board
    @color = color
    @name = name
  end

  def to_s
    if @color == :white
      WHITE_PRINTABLE[@name]
    else
      BLACK_PRINTABLE[@name]
    end
  end

  def add_array(arr1, arr2)
    [arr1.first + arr2.first, arr1.last + arr2.last]
  end

  def valid_move?(pos)
    @board.in_bounds?(pos) && @board[*pos].color != @color
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
        valid_move?(new_pos) ? result << new_pos : break
        break if board[*new_pos].color != nil
      end
    end
    result
  end

end

class SteppingPiece < Piece

  def moves
    # debugger
    result = []
    MOVES[name].each do |move|
      new_pos = add_array(pos, move)
      result << new_pos if valid_move?(new_pos)
    end
    result
  end

end

class Pawn < Piece
  attr_reader :multiplier

  PAWN_FORWARD = {
    white: [[-2, 0], [-1, 0]],
    black: [[2, 0], [1, 0]]
  }

  PAWN_DIAGONAL = {
    white: [[-1, 1], [-1, -1]],
    black: [[1, 1], [1, -1]]
  }

  def initialize(pos, board, color, name)
    super(pos, board, color, name)
    @moved = false
  end

  def moves
    @moved ? result = PAWN_FORWARD[@color].drop(1) : result = PAWN_FORWARD[@color].drop(0)
    result.select! do |diff|
      possible_pos = add_array(@pos, diff)
      @board[*possible_pos].class == NullPiece
    end
    result.concat(pawn_helper)
    possible_moves = result.map do |diff|
      add_array(@pos, diff)
    end
    possible_moves.select do |move|
      @board.in_bounds?(move)
    end
  end

  def pawn_helper
    result = []
    PAWN_DIAGONAL[@color].each do |diag|
      new_pos = add_array(pos, diag)
      if board[*new_pos].color != @color && !board[*new_pos].color.nil?
        result << diag
      end
    end
    result
  end

  def move_pawn
    @moved = true
  end
end

class NullPiece
  include Singleton

  def moves
  end

  def to_s
    " "
  end

  def add_array(arr1, arr2)
  end

  def valid_move?(pos)
  end

  attr_reader :board, :color, :name
  attr_accessor :pos

end
