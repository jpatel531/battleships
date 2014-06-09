require_relative 'coordinate_tracker'
require_relative 'coordinate_converter'

module Coordinate

	include CoordinateTracker
	include CoordinateConverter

	attr_reader :row, :column
	attr_writer :targeted
	attr_accessor :has_ship

	def self.included(base)
		base.extend CoordinateTracker
	end

	def initialize(row, column)
		@targeted, @has_ship = false, false
		@row = (row.is_a? String) ? convert(row) : row
		@column = column.to_i
		self.class.existing_coordinates << self
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

  def miss?
  	targeted? && !has_ship?
  end

end

class Player1HomeCoordinate; include Coordinate ; end
class Player2HomeCoordinate; include Coordinate ; end




