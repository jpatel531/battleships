class Coordinate

	attr_reader :row, :column
	attr_writer :targeted

	def initialize(row, column)
		@targeted, @has_ship = false, false
		@row = (row.is_a? String) ? convert(row) : row
		@column = column.to_i
	end

	def convert(row)
		row.to_i(27) - 9
	end

	def targeted?
		@targeted
	end

	def hold(ship)
		ship.locations << self
		@has_ship = true
	end	

	def has_ship?
		@has_ship
	end

end