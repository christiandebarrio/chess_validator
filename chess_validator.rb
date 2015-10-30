require 'pry'

class Board
	
	def initialize list_pieces
		@board = Array.new(8) { Array.new(8) }
		@board[0][0] = :bR
		@board[1][5] = :bR
		@list_pieces = list_pieces
	end

	def move
		@move_ini = [0, 0]
		@move_end = [0, 5]

		check_move
	end

	def select_piece_on_board
		@piece_selected = @board[@move_ini[0]][@move_ini[1]]		
	end

	def create_piece_with_position name_piece
		@piece = @list_pieces[name_piece].new @move_ini
		puts @piece
	end

	def empty?
		@board[@move_end[0]][@move_end[1]] == nil
	end

	def check_move
		select_piece_on_board
		create_piece_with_position(@piece_selected)
		if @piece.rule_movement?(@move_end) && empty?
			puts "LEGAL"
		else
			puts "ILEGAL"
		end
	end

	# def add_piece piece
	# 	@board = @empty_board
	# 	#binding.pry
	# 	new_piece = @list_pieces[piece].new "black"
	# 	position_on_board = @board[new_piece.position[0]] [new_piece.position[1]]
	# 	binding.pry
	# 	position_on_board = new_piece.name
	# 	p @board

	# end
 
end

class Piece

	def initialize position_ini
		@position_ini = position_ini
	end
end


class Rook < Piece
	attr_accessor :position

	def rule_movement? position_end
		@position_ini[0] == position_end[0] || @position_ini[1] == position_end[1]
	end

end



list_pieces = {
	bR: Rook,
}

chess = Board.new list_pieces
chess.move 

# chess.add_piece :bR

# KING –> REY

# ROOK –> TORRE

# PAWN –> PEÓN

# KNIGHT –> CABALLO

# QUEEN –> DAMA

# BISHOP –> ALFIL