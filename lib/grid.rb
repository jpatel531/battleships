require 'matrix'

class Grid

	def build
		Matrix.zero(10)
	end

	# def draw_from(coordinate)
	# 	coordinate.existing_coordinates.each do |location|
	# 		# self.build.[](location.row - 1, location.column - 1 ) = 9 if location.has_ship?
	# 		self.build.to_a[location.row - 1][location.column   "S" if location.has_ship?
	# 	end
	# end

end

class HomeGrid < Grid
end


class TrackingGrid < Grid
end

