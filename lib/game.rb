require_relative 'player'
require_relative 'grid'

class Game

	attr_reader :player1, :player2, :player1_home_grid, :player2_home_grid

	def initialize
		@player1 = Player.new("Jamie", true)
		@player2 = Player.new("John", false)
		@player1_home_grid = Player1HomeGrid.new(player1)
		@player2_home_grid = Player2HomeGrid.new(player2)
	end

end
 
