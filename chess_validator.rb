require 'pry'

module Movements

	def straight coordinate_ini, coordinate_end
		coordinate_ini[0] == coordinate_end[0] || coordinate_ini[1] == coordinate_end[1]
	end

	def diagonal coordinate_ini, coordinate_end
		coordinate_ini.sort
		coordinate_end.sort
		coordinate_ini[0] - coordinate_ini[1] == coordinate_end[0] - coordinate_end[1]
	end


end

class Board
	
	def initialize coordinate_ini, coordinate_end, list_pieces
		@board = Array.new(8) { Array.new(8) }
		@coordinate_ini = coordinate_ini
		@coordinate_end = coordinate_end
		@list_pieces = list_pieces
		@board[5][5] = :wQ
		@board[3][3] = :bR
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
		coordinate[0] = coordinate[0].ord - 97
		coordinate[1] = coordinate[1].to_i
		coordinate
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
		straight(@coordinate_ini, @coordinate_end)
	end

end

class Queen < Piece

	def rule_movement? coordinate_end
		straight(@coordinate_ini, coordinate_end) || diagonal(@coordinate_ini, coordinate_end)
	end

end
 




list_pieces = {
	bR: Rook,
	wR: Rook,
	bQ: Queen,
	wQ: Queen,
}

validate = ChessValidator.new(list_pieces)
validate.make_move("f5 f0")


# KING –> REY
# ROOK –> TORRE
# PAWN –> PEÓN
# KNIGHT –> CABALLO
# QUEEN –> DAMA
# BISHOP –> ALFIL