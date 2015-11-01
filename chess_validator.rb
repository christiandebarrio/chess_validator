require 'pry'

module Movements

  def horizontal coordinate_ini, coordinate_end
    coordinate_ini[0] == coordinate_end[0]
  end

  def vertical coordinate_ini, coordinate_end
    coordinate_ini[1] == coordinate_end[1]
  end

  def diagonal coordinate_ini, coordinate_end
    (coordinate_ini[0] - coordinate_end[0]).abs == (coordinate_ini[1] - coordinate_end[1]).abs
  end

  def one_step_horizontal coordinate_ini, coordinate_end
    horizontal(coordinate_ini, coordinate_end) && (coordinate_ini[1] - coordinate_end[1]).abs == 1
  end

  def one_step_vertical coordinate_ini, coordinate_end
    vertical(coordinate_ini, coordinate_end) && (coordinate_ini[0] - coordinate_end[0]).abs == 1
  end

  def two_steps_vertical coordinate_ini, coordinate_end
    vertical(coordinate_ini, coordinate_end) && (coordinate_ini[0] - coordinate_end[0]).abs == 2
  end

  def one_step_diagonal coordinate_ini, coordinate_end
    diagonal(coordinate_ini, coordinate_end) && (coordinate_ini[0] - coordinate_end[0]).abs == 1
  end

  def up coordinate_ini, coordinate_end
    coordinate_ini[0] > coordinate_end[0]
  end

  def down coordinate_ini, coordinate_end
    coordinate_ini[0] < coordinate_end[0]
  end

end

class Board
  
  def initialize coordinate_ini, coordinate_end, list_pieces
    @board = Array.new(8) { Array.new(8) }
    @coordinate_ini = coordinate_ini
    @coordinate_end = coordinate_end
    @list_pieces = list_pieces
    @board[4][3] = :wP
    @board[6][3] = :bR
    check_move
  end

  def check_move
    select_piece_on_board
    create_piece_with_position_and_color
    if @piece.rule_movement?(@coordinate_end) && destination_empty?
      puts "LEGAL"
    else
      puts "ILEGAL"
    end
  end

  def select_piece_on_board
    @piece_selected = @board[@coordinate_ini[0]][@coordinate_ini[1]]
  end

  def create_piece_with_position_and_color
    if @piece_selected[0] == "b"
      color = "black"
    elsif @piece_selected[0] == "w"
      color = "white"
    end
    @piece = @list_pieces[@piece_selected].new(@coordinate_ini, color)
    puts @piece
    puts @piece.color
    puts @coordinate_ini
    puts @coordinate_end
  end

  def destination_empty?
    @board[@coordinate_end[0]][@coordinate_end[1]] == nil
  end

end

class ChessValidator
  attr_accessor :list_pieces, :coordinate_ini, :coordinate_end

  def initialize list_pieces
    @list_pieces = list_pieces
  end

  def make_move string_coordinates
    string_to_coordinate string_coordinates
    @coordinate_ini = convert_coordinate(@coordinate_ini)
    @coordinate_end = convert_coordinate(@coordinate_end)
    @board = Board.new(@coordinate_ini, @coordinate_end, @list_pieces)
  end

  def string_to_coordinate string
        @coordinate_ini = string.split(" ")[0].split("")
        @coordinate_end = string.split(" ")[1].split("")
  end

  def convert_coordinate coordinate
    convert_coordinate = []
    convert_coordinate[0] = 8 - coordinate[1].to_i
    convert_coordinate[1] = coordinate[0].ord - 97
    convert_coordinate
  end
end


class Piece
  include Movements

  attr_accessor :color

  def initialize coordinate_ini, color
    @coordinate_ini = coordinate_ini
    @color = color
  end
end


class Rook < Piece

  def rule_movement? coordinate_end
    horizontal(@coordinate_ini, coordinate_end) || vertical(@coordinate_ini, coordinate_end)
  end

end

class Queen < Piece

  def rule_movement? coordinate_end
    horizontal(@coordinate_ini, coordinate_end) || vertical(@coordinate_ini, coordinate_end) || diagonal(@coordinate_ini, coordinate_end)
  end

end

class Bishop < Piece

  def rule_movement? coordinate_end
    diagonal(@coordinate_ini, coordinate_end)
  end

end
 
class King < Piece

  def rule_movement? coordinate_end
    one_step_horizontal(@coordinate_ini, coordinate_end) || one_step_vertical(@coordinate_ini, coordinate_end) || one_step_diagonal(@coordinate_ini, coordinate_end)
  end

end

class Pawn < Piece

  def rule_movement? coordinate_end
    case @color
      when "black" then
        if @coordinate_ini[0] == 1
          two_steps_vertical(@coordinate_ini, coordinate_end) || one_step_vertical(@coordinate_ini, coordinate_end) && down(@coordinate_ini, coordinate_end)
        else
          one_step_vertical(@coordinate_ini, coordinate_end) && down(@coordinate_ini, coordinate_end)
        end
      when "white" then
        if @coordinate_ini[0] == 6
          two_steps_vertical(@coordinate_ini, coordinate_end) || one_step_vertical(@coordinate_ini, coordinate_end) && up(@coordinate_ini, coordinate_end)
        else
          one_step_vertical(@coordinate_ini, coordinate_end) && up(@coordinate_ini, coordinate_end)
        end
    end
    true
  end

end

list_pieces = {
  bR: Rook,
  wR: Rook,
  bQ: Queen,
  wQ: Queen,
  bB: Bishop,
  wB: Bishop,
  bK: King,
  wK: King,
  bP: Pawn,
  wP: Pawn,
}

validate = ChessValidator.new(list_pieces)
validate.make_move("d4 d5")


# KING –> REY
# ROOK –> TORRE
# PAWN –> PEÓN
# KNIGHT –> CABALLO
# QUEEN –> DAMA
# BISHOP –> ALFIL