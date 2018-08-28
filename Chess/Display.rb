require 'colorize'
require_relative 'Board.rb'
require_relative 'Cursor.rb'

class Display
  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @board = board
    render
  end

  def render
    while true
      system "clear"
      @board.grid.each.with_index do |row,i|
        row.each.with_index do |char,j|
          if @cursor.cursor_pos == [i, j]
            render_cursor([i, j], char)
          else
            render_tile([i,j], char)
          end
        end
        print "\n"
      end
      @cursor.get_input
    end
  end

  def render_cursor(pos, char)
    print char.type.colorize(
      :color => char.color,
      :background => :cyan
    ).blink
  end

  def render_tile(pos, char)
    print char.type.colorize(
      :color => char.color,
      :background => @board.tile_color(pos)
    )
  end
end

display = Display.new(Board.new)
