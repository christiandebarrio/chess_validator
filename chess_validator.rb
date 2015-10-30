require 'pry'

module Movements

	def straight position_ini, position_end
		position_ini[0] == position_end[0] || position_ini[1] == position_end[1]
	end

	def diagonal position_ini, position_end
		position_ini.sort
		position_end.sort
		position_ini[0] - position_ini[1] == position_end[0] - position_end[1]
	end
end

class Board
	
	def initialize list_pieces
		@board = Array.new(8) { Array.new(8) }
		@board[5][5] = :bQ
		@board[3][3] = :bR
		@list_pieces = list_pieces

	end

	def move
		@move_ini = [5, 5]
		@move_end = [3, 3]

		check_move
	end

	def select_piece_on_board
		@piece_selected = @board[@move_ini[0]][@move_ini[1]]
		puts @piece_selected
	end

	def create_piece_with_position name_piece
		@piece = @list_pieces[name_piece].new @move_ini
		puts @piece
	end

	def destination_empty?
		@board[@move_end[0]][@move_end[1]] == nil
	end

	def check_move
		select_piece_on_board
		create_piece_with_position(@piece_selected)
		if @piece.rule_movement?(@move_end) || destination_empty?
			puts "LEGAL"
		else
			puts "ILEGAL"
		end
	end

 
end

class ChessValidator

	def initialize
		#Board.new list_pieces
	end

	def make_move string_coordinates
		string_to_coordinate string_coordinates
		@coordinate_ini = convert_coordinate(@coordinate_ini)
		@coordinate_end = convert_coordinate(@coordinate_end)
		@board = Board.new list_pieces
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

	def initialize position_ini
		@position_ini = position_ini
	end
end


class Rook < Piece
	attr_accessor :position

	def rule_movement? position_end
		straight(@position_ini, position_end)
	end

end

class Queen < Piece
	attr_accessor :position

	def rule_movement? position_end
		straight(@position_ini, position_end) && diagonal(@position_ini, position_end)
	end

end




list_pieces = {
	bR: Rook,
	bQ: Queen,
}

chessvalidator = ChessValidator.new
chessvalidator.make_move("a2 a3")

# chess.add_piece :bR

# KING –> REY

# ROOK –> TORRE

# PAWN –> PEÓN

# KNIGHT –> CABALLO

# QUEEN –> DAMA

# BISHOP –> ALFIL