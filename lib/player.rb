require_relative 'ship'
require_relative 'ship_types'
require_relative 'coordinate'

class Player

	attr_reader :aircraftcarrier, :battleship, :destroyer, :submarine, :tug, :defending_coordinates, :attacking_coordinates

	def initialize(name, player1 = true)
		@name = name
		@aircraftcarrier = AircraftCarrier.new
		@battleship = Battleship.new
		@destroyer = Destroyer.new
		@submarine = Submarine.new
		@tug = Tug.new
		@defending_coordinates = (player1 == true) ? Player1HomeCoordinate : Player2HomeCoordinate
		@attacking_coordinates = (player1 == true) ? Player2HomeCoordinate : Player1HomeCoordinate
	end

	def ships
		[aircraftcarrier, battleship, destroyer, submarine, tug]
	end

	def chosen(ship)
		instance_variable_get("@"+ship)
	end

	def specified(coordinate, status=:defending)
		column = coordinate[2].nil? ? coordinate[1] : "#{coordinate[1]}#{coordinate[2]}"
		if status == :attacking
			attacking_coordinates.new(coordinate[0],column) if status == :attacking
		else
			defending_coordinates.new(coordinate[0],column) if status == :defending
		end
	end

	def set(ship, orientation)
		ship.horizontal = false if orientation == "vertical"
	end

	def place(ship, coordinate, orientation="horizontal")
		set(chosen(ship), orientation)
		chosen(ship).defending_coordinates = self.defending_coordinates
		specified(coordinate).hold chosen(ship)
		chosen(ship).extend_coordinates
	end

	def target(coordinate)
		attacking_coordinates.existing_coordinates.each do |location| 
				if location.original_string == coordinate
					location.targeted = true
				else
					specified(coordinate, :attacking).targeted = true
				end
		end
	end

end
