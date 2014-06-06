require_relative 'game'

class Grid

	include Game

	attr_reader :display, :defender, :attacker, :coordinate_system

	def initialize
		@display = Array.new(10).map!{Array.new(10)}
		@coordinate_system = Coordinate
	end

	def mark_ships
		defender.ships.each do |ship|
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

	def mark_misses
		coordinate_system.existing_coordinates.each do |location|
			display[location.row - 1][location.column - 1] = "M" if location.miss?
		end
	end

	def mark_hits
		defender.ships.each do |ship|
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
		mark_ships if viewer == defender
		mark_misses
		mark_hits
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







