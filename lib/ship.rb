class Ship

	attr_accessor :length, :horizontal, :defending_coordinates

	def initialize(length = 3)
		@length = length
		@horizontal = true
	end

	def horizontal?
		@horizontal
	end

	def locations
		@locations ||= []
	end

	def placed?
		!locations.empty?
	end

	def hit_locations
		locations.select {|location| location.targeted? }
	end

	def sunk?
		hit_locations.length == self.length
	end

	def extend_coordinates
		1.upto(self.length - 1) do |index|
			x = horizontal? ? locations[0].row : locations[0].row + index
			y = horizontal? ? locations[0].column + index : locations[0].column 
			locations << defending_coordinates.new(x, y)
		end
		locations.each {|location| location.has_ship = true}
	end
end
