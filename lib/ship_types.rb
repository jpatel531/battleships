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

class Submarine < Ship
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
