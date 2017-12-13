module SlidingPieceM

  def moves
    possible_moves = []
    x_cur_loc, y_cur_loc = self.location

    rook_queen = [:rook_white, :rook_black, :queen_white, :queen_black]

    if rook_queen.include?(self.type)

      (0..7).to_a.each do |idx|
        possible_moves << [x_cur_loc, idx]
        possible_moves << [idx, y_cur_loc]
      end
    end

    bishop_queen = [:bishop_white, :bishop_black, :queen_black, :queen_white]

    if bishop_queen.include?(self.type)
      (0..7).to_a.each do |x_index|
        (0..7).to_a.each do |y_index|
          next if x_index == x_cur_loc
          if ((y_index - y_cur_loc).to_f / (x_index - x_cur_loc)).abs == 1
            possible_moves << [x_index, y_index]
          end
        end
      end
    end
    possible_moves.uniq.reject {|e| e == self.location }
  end

end

module SteppingPieceM
  def moves
    possible_moves = []
    x_cur_loc, y_cur_loc = self.location

    kings = [:king_black, :king_white]

    if kings.include?(self.type)
      differences = [
        [0, 1],
        [1, 0],
        [1, 1],
        [0, -1],
        [-1, 0],
        [-1, -1],
        [-1, 1],
        [1, -1]
      ]

      differences.each do |dif|
        move = [dif[0] + x_cur_loc, dif[1] + y_cur_loc]
        possible_moves << move unless move.any? {|e| e > 7 || e < 0}
      end
    end

    knights = [:knight_white, :knight_black]
    if knights.include?(self.type)
      differences = [
        [2, 1],
        [-2, 1],
        [1, 2],
        [-1, 2],
        [2, -1],
        [-2, -1],
        [1, -2],
        [-1, -2]
      ]

      differences.each do |dif|
        move = [dif[0] + x_cur_loc, dif[1] + y_cur_loc]
        possible_moves << move unless move.any? {|e| e > 7 || e < 0}
      end

    end
    possible_moves
  end



end

class Piece
  attr_accessor :selected, :location
  attr_reader :type

  MAPPED_PIECES = {
    pawn_white: '♙'
  }
  def initialize(piece, location)
    @piece_icon = MAPPED_PIECES[piece]
    @selected = false
    @type = piece
    @location = location
  end

  def to_s
    if @selected
      return @piece_icon.colorize(:color => :light_blue, :background => :red) + ' '
    else
      return @piece_icon + ' '
    end
  end

end

class SlidingPiece < Piece
  include SlidingPieceM

  def initialize(piece, location)
    super
  end

end

class SteppingPiece < Piece
  include SteppingPieceM

  def initialize(piece, location)
    super
  end
end

class Pawn < Piece

  def intialize(piece, location)
    super
  end

  def moves
    possible_moves = []
    x_cur_loc, y_cur_loc = self.location

    if self.type == :pawn_white
      differences = [
        [-1, 0],
        [-1, 1],
        [-1, -1],
      ]

      differences.each do |dif|
        move = [dif[0] + x_cur_loc, dif[1] + y_cur_loc]
        possible_moves << move unless move.any? {|e| e > 7 || e < 0}
      end
    end
    if self.type == :pawn_black
      differences = [
        [1, 0],
        [1,-1],
        [1, 1],
      ]

      differences.each do |dif|
        move = [dif[0] + x_cur_loc, dif[1] + y_cur_loc]
        possible_moves << move unless move.any? {|e| e > 7 || e < 0}
      end
    end
    possible_moves
  end

end


class NullPiece < Piece
  def initialize
    @piece_icon = ' '
  end

  def to_s
    super
  end
end

# a = SteppingPiece.new(:knight_white, [3,3])
# p a.moves
