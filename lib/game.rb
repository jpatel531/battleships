require_relative 'player'
require_relative 'grid'
require_relative 'grid_types'

class Game

	attr_reader :player1, :player2, :player1_home_grid, :player2_home_grid

	def initialize
		@player1 = Player.new("Jamie", true)
		@player2 = Player.new("John", false)
		@player1_home_grid = Player1HomeGrid.new(player1)
		@player2_home_grid = Player2HomeGrid.new(player2)
	end

	def input
		STDIN.gets.chomp
	end

	def ship
		puts "Which ship would you like to place?"
		input
	end

	def coordinate
		puts "Where would you like to place it?"
		input
	end

	def orientation
		puts "horizontal or vertical orientation?"
		input
	end

	def place_ship(player)
		begin
			player.place(ship, coordinate, orientation)
		rescue OutOfBounds =>
			e.message
		end
	end

	def turn_to_place(player)
		place_ship(player) until player.all_deployed?
	end

	def placing_round
		turn_to_place(player1)
		turn_to_place(player2)
	end

end

class OutOfBounds < Exception ; end
 
