class Board
  attr_reader :grid
  
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
end
