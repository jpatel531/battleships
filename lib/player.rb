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

	def choose(ship)
		instance_variable_get("@"+ship)
	end

end
