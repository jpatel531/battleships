require_relative 'ship'
require_relative 'ship_types'
# require_relative 'grid'


class Player


	attr_reader :aircraftcarrier, :battleship, :destroyer, :submarine, :tug, :defending_coordinates, :attacking_coordinates

	def initialize(name)
		@name = name
		@aircraftcarrier = AircraftCarrier.new
		@battleship = Battleship.new
		@destroyer = Destroyer.new
		@submarine = Submarine.new
		@tug = Tug.new
	end

	require_relative 'game'

	include Game

	# def defending_coordinates
	# 	@defending_coordinates = (self == PLAYER1) ? Player1HomeCoordinate : Player2HomeCoordinate
	# end

	# def attacking_coordinates
	# 	@attacking_coordinates = (self == PLAYER1) ? Player2HomeCoordinate : Player1HomeCoordinate
	# end

	def ships
		[aircraftcarrier, battleship, destroyer, submarine, tug]
	end

	def chosen(ship)
		instance_variable_get("@"+ship)
	end

	def specified(coordinate)
		column = coordinate[2].nil? ? coordinate[1] : "#{coordinate[1]}#{coordinate[2]}"
		Coordinate.new(coordinate[0],column) 

	end

	def set(ship, orientation)
		ship.horizontal = false if orientation == "vertical"
	end

	def place(ship, coordinate, orientation="horizontal")
		set(chosen(ship), orientation)
		specified(coordinate).hold chosen(ship)
		chosen(ship).extend_coordinates
	end

	def target(coordinate)
		Coordinate.existing_coordinates.each do |location| 
				if location.original_string == coordinate
					location.targeted = true
				else
					specified(coordinate).targeted = true
				end
		end
	end

end
