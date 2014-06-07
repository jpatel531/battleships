require 'player'
require 'coordinate'
# require 'game'

describe Player do

	let (:player) {Player.new("Tron")	}

	context "when initialized" do

		it "should have an aircraft carrier, battleship, destroyer, submarine and tug" do
		 ship_types = []
		 player.ships.each {|ship| ship_types << ship.class}
		 expected_types = [AircraftCarrier, Battleship, Destroyer, Submarine, Tug]
		 expect(ship_types).to eq expected_types
		end

		it "always has the same aircraft carrier" do 
			aircraft_carrier = lambda {|ship| ship.class == AircraftCarrier}
			carrier1 = player.ships.select(&aircraft_carrier)
			carrier2 = player.ships.select(&aircraft_carrier)
			expect(carrier1).to eq carrier2
		end

	end
	
	context "inputting a string" do

		it "will choose the relevant ship" do 
			ship = "aircraftcarrier"
			expect(player.chosen(ship)).to eq(player.aircraftcarrier)
		end

		it "will create a starting coordinate" do
			coordinate = "A1"
			expect(player.specified(coordinate).display).to eq "(1,1)"
		end

		it "can create a coordinate A10" do 
			coordinate = "A10"
			expect(player.specified(coordinate).display).to eq "(1,10)"
		end
			
		it "can specify the vertical orientation" do
			ship = player.submarine
			orientation = "vertical"
			player.set(ship, orientation)
			expect(ship.horizontal?).to be_false
		end
	end

	context "playing the game" do 

		it "can place a ship on the grid" do
			player.place("tug","A1", "vertical")
			carrier = []
			player.tug.locations.each {|location| carrier << location.display}
			expect(carrier).to eq ["(1,1)", "(2,1)"]
		end


		it "can target a coordinate that already exists" do 
			coordinate = Player2HomeCoordinate.new("A","1")
			player.target("A1")
			expect(coordinate.targeted?).to be_true
		end

		it "can target a coordinate that doesn't exist" do 
			Player2HomeCoordinate.existing_coordinates.clear
			Player2HomeCoordinate.new("B", "2")
			player.target("A1")
			a1 = Player2HomeCoordinate.existing_coordinates.select {|location| location.original_string == "A1"}
			expect(a1).not_to be_empty
		end
	
	end


end