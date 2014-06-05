require_relative 'ship'
require_relative 'ship_types'

class Player

	attr_reader :aircraftcarrier, :battleship, :destroyer, :submarine, :tug

	def initialize(name)
		@name = name
		@aircraftcarrier = AircraftCarrier.new
		@battleship = Battleship.new
		@destroyer = Destroyer.new
		@submarine = Submarine.new
		@tug = Tug.new
	end

	def ships
			[aircraftcarrier, battleship, destroyer, submarine, tug]
	end

	def chosen(ship)
		instance_variable_get("@"+ship)
	end

	def specified(coordinate)
		column = coordinate[2].nil? ? coordinate[1] : "#{coordinate[1]}#{coordinate[2]}"
		@specified = Coordinate.new(coordinate[0],column)
	end

	def set(ship, orientation)
		ship.horizontal = false if orientation == "vertical"
	end

	def place(ship, coordinate, orientation)
		set(chosen(ship), orientation)
		specified(coordinate).hold chosen(ship)
		chosen(ship).extend_coordinates
	end

	def target(coordinate)
		Coordinate.existing_coordinates.each do |location| 
				location.targeted = true if location.original_string == coordinate
		end
	end

end
