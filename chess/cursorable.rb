require "io/console"

module Cursorable
  KEYMAP = {
    " " => :space,
    "h" => :left,
    "j" => :down,
    "k" => :up,
    "l" => :right,
    "w" => :up,
    "a" => :left,
    "s" => :down,
    "d" => :right,
    "\t" => :tab,
    "\r" => :return,
    "\n" => :newline,
    "\e" => :escape,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\177" => :backspace,
    "\004" => :delete,
    "\u0003" => :ctrl_c,
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
               # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a numeric keycode.
                           # chr returns a string of the character represented by the keycode.
                           # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads at most maxlen
                                                 # bytes from a data stream; it's nonblocking
                                                 # in that the method executes asynchronously;
                                                 # it raises an error if no data is available,
                                                 # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :return, :space
      @move_pos = @cursor_pos
      @selected = true
      if !@selected_pos.nil? && @board[*@selected_pos].moves.include?(@move_pos)
        @board.move(@selected_pos, @move_pos)
        @selected_pos = nil
        @move_pos = nil
        @selected = false
      elsif @selected && @board[*@cursor_pos].color == @game.current_player.color
        @selected_pos = @cursor_pos
      else
        @selected = false
      end
      @cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    else
      puts key
    end
  end

  def update_pos(diff)
    new_pos = [@cursor_pos.first + diff.first, @cursor_pos.last + diff.last]
    @cursor_pos = new_pos if @board.in_bounds?(new_pos)
  end
end
