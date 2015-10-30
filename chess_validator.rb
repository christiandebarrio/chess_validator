class Board
	
	def initialize
		@empty_board = Array.new(8) { Array.new(8) }
	end

	def start_game

	end


end

class Piece

end


class Rook < Piece

	def initialize color
		@name = color + "R"
		@position = [0, 0]
	end

end

piezes = {
	bR: Rook,
}

chess = Board.new
chess.start_game

# KING –> REY

# ROOK –> TORRE

# PAWN –> PEÓN

# KNIGHT –> CABALLO

# QUEEN –> DAMA

# BISHOP –> ALFIL