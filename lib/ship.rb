class Ship

	attr_accessor :length

	
	def initialize(length = 3)
		@length = length
		@horizontal = true
	end

	def horizontal?
		@horizontal
	end

	def place_vertically!
		@horizontal = false
	end

	def locations
		@locations ||= []
	end

	def hit_locations
		locations.select {|location| location.targeted? }
	end

	def sunk?
		hit_locations.length == self.length
	end

	def extend_coordinates
		1.upto(self.length - 1) do |index|
			x = horizontal? ? locations[0].row : locations[0].column + index
			y = horizontal? ? locations[0].row + index : locations[0].column 
			locations << Coordinate.new(x, y)
		end
	end
end


class AircraftCarrier < Ship
	def initialize
		@length = 5
	end
end

class Battleship < Ship
	def initialize
		@length = 4
	end
end

class Destroyer < Ship
	def initialize
		@length = 3
	end
end

class Tug < Ship
	def initialize
		@length = 2
	end
end
