	require_relative 'player'

# module Initializer

# 	# PLAYER1 = Player.new(get_name, true)
# 	# PLAYER2 = Player.new(get_name, false)

# 	def get_name
# 		STDIN.gets.chomp
# 	end

# 	PLAYER1 = Player.new(get_name, true)
# 	PLAYER2 = Player.new(get_name, false)

# 	PLAYER1HOMEGRID = Player1HomeGrid.new
# 	PLAYER2HOMEGRID = Player2HomeGrid.new

# end

class Game

	attr_reader :player1, :player2, :player1_home_grid, :player2_home_grid

	def initialize
		@player1 = Player.new("Jamie", true)
		@player2 = Player.new("John", false)
		@player1_home_grid = Player1HomeGrid.new(player1)
		@player2_home_grid = Player2HomeGrid.new(player2)
	end

end
 
