require_relative 'player'
require_relative 'grid'
require_relative 'grid_types'

class Game

	attr_reader :player1, :player2, :player1_home_grid, :player2_home_grid
	attr_accessor :current_player

	def initialize
		@player1 = Player.new("Jamie", true)
		@player2 = Player.new("John", false)
		@player1_home_grid = Player1HomeGrid.new(player1)
		@player2_home_grid = Player2HomeGrid.new(player2)
		@current_player = player1
	end

	def switch_player
		@current_player = (current_player == player1) ? player2 : player1
	end

	def place_ships(ship, coordinate, orientation="horizontal")
		current_player.place(ship, coordinate, orientation)
	end

	def turn_to_place(ship, coordinate, orientation="horizontal")
		place_ships(ship, coordinate, orientation="horizontal") unless current_player.all_deployed?
		switch_player if current_player.all_deployed?
		place_ships(ship, coordinate, orientation="horizontal")
	end

	def placing_round
		# loop { turn_to_place  ; switch_player }
	end

	def target_ships(player)
		player.target(coordinate)
	end

end

class OutOfBounds < Exception ; end
 
