require_relative 'piece.rb'
require_relative 'display.rb'

class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    [0,1,6,7].each do |rowIndex|
      row = @grid[rowIndex]
      row.each_with_index do |cell, colIndex|
        @grid[rowIndex][colIndex] = Piece.new(:pawn_white)
      end
    end

    (2..5).to_a.each do |rowIndex|
      row = @grid[rowIndex]
      row.each_with_index do |cell, colIndex|
        @grid[rowIndex][colIndex] = NullPiece.new
      end
    end


  end

  def play
    display = Display.new(self)

    while !over
      system 'clear'
      display.render(self)
      display.cursor.get_input
    end
  end

  def over
    false
  end

  def move_piece (start_pos, end_pos)
    begin
      raise StandardError.new("No piece at this position") if self[start_pos].is_a?(NullPiece)
    end
    self[start_pos], self[end_pos] = NullPiece.new, self[start_pos]
  end

  def [](x,y)
    @grid[x][y]
  end

  def []=(x,y, value)
    @grid[x][y] = value
  end

end

b = Board.new.play
