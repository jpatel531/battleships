class Grid

	attr_reader :display

	def initialize
		@display = Array.new(10).map!{Array.new(10)}
	end

	def mark_ships_from(coordinates)
		coordinates.existing_coordinates.each do |location|
			display[location.row - 1][location.column - 1] = "S" if location.has_ship?
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

	def mark_sinks_to(player)
		player.ships.each do |ship|
			ship.hit_locations.each do |location|
				display[location.row - 1][location.column - 1] = ":(" if ship.sunk?
			end
		end
	end

	def pretty
		puts grid.display.map(&:inspect)
	end

end


