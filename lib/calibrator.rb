require_relative 'game'

module CoordinateCalibrator

 attr_reader :defending_coordinates, :attacking_coordinates	

 	def defending_coordinates
		@defending_coordinates = (self == PLAYER1) ? Player1HomeCoordinate : Player2HomeCoordinate
	end

	def attacking_coordinates
		@attacking_coordinates = (self == PLAYER1) ? Player2HomeCoordinate : Player1HomeCoordinate
	end

end