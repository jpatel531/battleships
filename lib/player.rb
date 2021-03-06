require_relative 'ship'
require_relative 'ship_types'
require_relative 'coordinate'
require_relative 'game'

class Player

	attr_reader :aircraftcarrier, :battleship, :destroyer, :submarine, :tug, :defending_coordinates, :attacking_coordinates
	attr_accessor :name

	def initialize(player1 = true)
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

	def all_deployed?
		(ships.select {|ship| ship.placed?}).count == 5
	end

	def chosen(ship)
		instance_variable_get("@"+ship)
	end

	def specified(coordinate, status=:defending)
		column = coordinate[2].nil? ? coordinate[1] : "#{coordinate[1]}#{coordinate[2]}"
		return "Stay on the board bro" if coordinate[0] > "J" || column.to_i > 10
		status == :attacking ? attacking_coordinates.new(coordinate[0],column) : defending_coordinates.new(coordinate[0],column)
	end

	def set(ship, orientation)
		ship.horizontal = false if orientation == "vertical"
	end

	def set_ship_properties(ship, orientation)
		set(chosen(ship), orientation)
		chosen(ship).defending_coordinates = self.defending_coordinates
	end

	def determine_ship_location(ship, coordinate)
		specified(coordinate).hold chosen(ship)
		chosen(ship).extend_coordinates 
	end

	def place(ship, coordinate, orientation="horizontal")
		unless unable_to_place?(ship, coordinate)
			set_ship_properties(ship, orientation)
			determine_ship_location(ship, coordinate)
		end
	end

	def unable_to_place?(ship, coordinate)
		match = match(coordinate, :defending)
		chosen(ship).placed? || (!match.nil? && match.has_ship?)
	end

	def match(coordinate, coordinate_system)
		grid_to_check = (coordinate_system == :attacking) ? attacking_coordinates : defending_coordinates
		return grid_to_check.existing_coordinates.find {|location| location.original_string == coordinate }
	end

	def target(coordinate)
		match = match(coordinate, :attacking)
		return "You already hit that bro" if !match.nil? && match.targeted?
		match.nil? ? (specified(coordinate, :attacking).targeted = true) : (match.targeted = true)
		return "Dench! Go again" if !match.nil? && match.hit?
	end

	def loser?
		ships.all? {|ship| ship.sunk? }
	end


end
