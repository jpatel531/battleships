module CoordinateTracker

	def existing_coordinates
		@existing_coordinates ||= []
	end

	def existing_coordinates=(value)
		@existing_coordinates = value
	end

end