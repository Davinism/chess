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
    puts "#{@previous_player} WINS!"
  end

  def switch_players
    @current_player, @previous_player = @previous_player, @current_player
  end

  def won?
    @board.checkmate?
  end
end
