require_relative 'ship'
require_relative 'ship_types'

class Player

	attr_reader :aircraft_carrier, :battleship, :destroyer, :submarine, :tug

	def initialize(name)
		@name = name
		@aircraft_carrier = AircraftCarrier.new
		@battleship = Battleship.new
		@destroyer = Destroyer.new
		@submarine = Submarine.new
		@tug = Tug.new
	end

	def ships
			[aircraft_carrier, battleship, destroyer, submarine, tug]
	end




end
