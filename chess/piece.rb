class Piece
  attr_accessor :selected

  MAPPED_PIECES = {
    pawn_white: '♙'
  }
  def initialize(piece)
    @piece_icon = MAPPED_PIECES[piece]
    @selected = false
  end

  def to_s
    if @selected
      return @piece_icon.colorize(:color => :light_blue, :background => :red) + ' '
    else
      return @piece_icon + ' '
    end
  end

end

class NullPiece < Piece
  def initialize
  end

  def to_s
    ' '
  end
end
