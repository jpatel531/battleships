require_relative 'grid'

class Player1HomeGrid < Grid 
	def initialize(defender)
		super
		@coordinate_system = Player1HomeCoordinate
	end
end

class Player2HomeGrid < Grid
	def initialize(defender)
		super
		@coordinate_system = Player2HomeCoordinate
	end
end