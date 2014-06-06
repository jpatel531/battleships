require_relative 'game'

class Grid

	include Game

	attr_reader :display, :defender, :attacker

	def initialize
		@display = Array.new(10).map!{Array.new(10)}
	end

	def mark_ships_of(player)
		player.ships.each do |ship|
			ship.locations.each do |location|
				display[location.row - 1][location.column - 1 ] = "S"
			end
		end
	end

	def unmark_ships
		display.each do |row|
			row.map! do |element|
				element = nil if element == "S"
			end
		end
	end

	def mark_misses_from(coordinates)
		coordinates.existing_coordinates.each do |location|
			display[location.row - 1][location.column - 1] = "M" if location.miss?
		end
	end

	def mark_hits_to(player)
		player.ships.each do |ship|
			ship.hit_locations.each do |location|
				display[location.row - 1][location.column - 1] = "H"
			end
		end
	end

	def pretty
		puts self.display.map(&:inspect)
	end

	def update_for(viewer)
		unmark_ships
		mark_ships_of(defender) if viewer == defender
		mark_misses_from(Coordinate)
		mark_hits_to(defender)
		pretty
	end
end

class Player1HomeGrid < Grid 
	def initialize
		super
		@defender = PLAYER1
		@attacker = PLAYER2
	end
end

class Player2HomeGrid < Grid
	def initialize
		super
		@defender = PLAYER2
		@attacker = PLAYER1
	end
end







