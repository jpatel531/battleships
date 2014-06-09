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

	def input
		STDIN.gets.chomp
	end

	def place_ship(player)
		puts "Which ship would you like to place?"
		ship = input
		puts "Where would you like to place it?"
		coordinate = input
		puts "horizontal or vertical orientation?"
		orientation = input
		player.place(ship, coordinate, orientation)
	end

	def turn_to_place(player)
		puts "#{player.name}: Place your ships!"
		5.times {place_ship(player)}
	end

	def placing_round
		turn_to_place(player1)
		turn_to_place(player2)
	end


end

class AlreadyPlaced < Exception ; end
 
