module CoordinateConverter

	def original_string
		("A".."Z").to_a[self.row - 1] + self.column.to_s
	end

	def display
		"(#{row},#{column})"
	end

	def convert(row)
		row.to_i(27) - 9
	end


end