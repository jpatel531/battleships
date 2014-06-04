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
		self
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

end

class AircraftCarrier < Ship
	def initialize
		@length = 5
		@horizontal = true
	end
end

class Battleship < Ship
	def initialize
		@length = 4
		@horizontal = true
	end
end

class Destroyer < Ship
	def initialize
		@length = 3
		@horizontal = true
	end
end

class Tug < Ship
	def initialize
		@length = 2
		@horizontal = true
	end
end
