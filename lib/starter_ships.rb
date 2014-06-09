module StarterShips

	attr_reader :aircraftcarrier, :battleship, :destroyer, :submarine, :tug

	STARTER_SHIPS = [@aircraftcarrier = AircraftCarrier.new,
		@battleship = Battleship.new,
		@destroyer = Destroyer.new,
		@submarine = Submarine.new,
		@tug = Tug.new]

end