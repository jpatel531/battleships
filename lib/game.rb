require_relative 'player'
require_relative 'grid'
require_relative 'grid_types'

class Game

	attr_reader :player1, :player2, :player1_home_grid, :player2_home_grid
	attr_accessor :current_player

	def initialize
		@player1 = Player.new(true)
		@player2 = Player.new(false)
		@player1_home_grid = Player1HomeGrid.new(player1)
		@player2_home_grid = Player2HomeGrid.new(player2)
		@current_player = player1
	end

	def coordinate
		gets.chomp
	end

	def ship
		gets.chomp
	end

	def orientation
		gets.chomp
	end

	def switch_player
		@current_player = (current_player == player1) ? player2 : player1
	end

	def place_ships
		current_player.place(ship, coordinate, orientation)
	end

	def placing_round
		place_ships
		current_player.all_deployed? ? switch_player : turn_to_place
		place_ships
	end

	def target_ships
		current_player.target(coordinate)
	end

	def player_has_another_hit?(result)
		result == "You already hit that bro" || result == "Dench! Go again"
	end

	def target_round
		result = target_ships
		player_has_another_hit?(result) ? target_round : switch_player
	end

	def victor
		player1.loser? ? player2 : player2.loser? ? player1 : nil
	end	

end