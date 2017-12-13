require 'colorize'
require_relative 'cursor'
require "byebug"

class Display
  attr_reader :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
  end

  def render(board)
    x,y = @cursor.cursor_pos
    board[x,y].selected = true

    (0..7).to_a.each do |rowIndex|
      puts ' '
      (0..7).to_a.each do |colIndex|

        piece = board[rowIndex, colIndex] #baord
        print piece

      end

    end
    puts
    board[x,y].selected = false
    print board.inputs
  end
end
