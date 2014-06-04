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

class Submarine < Ship
	def initialize
		@length = 3
	end
end

class Tug < Ship
	def initialize
		@length = 2
	end
end
