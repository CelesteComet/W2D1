require_relative 'piece.rb'
require_relative 'display.rb'
require 'byebug'

class Board
  attr_reader :grid, :inputs
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_board
    populate_null_pieces
    @inputs = []

  end

  def populate_null_pieces
    (2..5).to_a.each do |rowIndex|
      row = @grid[rowIndex]
      row.each_with_index do |cell, colIndex|
        @grid[rowIndex][colIndex] = NullPiece.new
      end
    end
  end

  def populate_board
    [0,1,6,7].each do |rowIndex|
      row = @grid[rowIndex]
      row.each_with_index do |cell, colIndex|
        @grid[rowIndex][colIndex] = Pawn.new(:pawn_white,[rowIndex,colIndex])
      end
    end
  end

  def play
    display = Display.new(self)

    while !over
      system 'clear'
      display.render(self)
      display.cursor.get_input #[-1,0]
      if @inputs.length == 2
        move_piece(@inputs[0], @inputs[1])
        @inputs = []
      end
      in_bounds(display.cursor)

    end
  end

  def over
    false
  end

  def in_bounds(cursor)
    cursor_pos = cursor.cursor_pos

    cursor_pos[0] = 0 if cursor_pos[0] < 0
    cursor_pos[0] = 7 if cursor_pos[0] > 7
    cursor_pos[-1] = 0 if cursor_pos[-1] < 0
    cursor_pos[-1] = 7 if cursor_pos[-1] > 7
  end

  def move_piece(start_pos, end_pos)
    sx, sy = start_pos
    ex, ey = end_pos
    begin
      raise StandardError.new("Not Valid Move") unless valid_move?(start_pos, end_pos)
    rescue
      return
    end
    self[sx, sy], self[ex, ey] = NullPiece.new, self[sx, sy]
    self[ex,ey].location = end_pos
  end

  def valid_move?(start_pos,end_pos)
    sx, sy = start_pos
    ex, ey = end_pos
    start_piece = self[sx, sy]
    end_piece = self[ex, ey]

    return false if start_piece.class == NullPiece
    return false if start_piece.type.to_s.split("_")[1] == end_piece.type.to_s.split("_")[1]
    return false unless start_piece.moves.include?(end_pos)
    true
  end

  def [](x,y)
    @grid[x][y]
  end

  def []=(x,y, value)
    @grid[x][y] = value
  end

end

b = Board.new.play
