require 'player'
require 'coordinate'
require 'game'

describe Player do

	let (:player) {Player.new("Tron")}

	context "when initialized" do

		it "should have 1 aircraft carrier" do
		 aircraft_carrier = lambda {|ship| ship.class == AircraftCarrier}
		 expect(player.ships.select(&aircraft_carrier)).not_to be_empty
		end

		it "always has the same aircraft carrier" do 
			 aircraft_carrier = lambda {|ship| ship.class == AircraftCarrier}
			 carrier1 = player.ships.select(&aircraft_carrier)
			 carrier2 = player.ships.select(&aircraft_carrier)
			 expect(carrier1).to eq carrier2
		end

		it "should have 1 battleship" do
		 	battleship = lambda {|ship| ship.class == Battleship}
		 	expect(player.ships.select(&battleship)).not_to be_empty
		end

		it "should have 1 destroyer" do
		 	destroyer = lambda {|ship| ship.class == Destroyer}
		 	expect(player.ships.select(&destroyer)).not_to be_empty
		end

		it "should have 1 submarine" do
		 	submarine = lambda {|ship| ship.class == Submarine}
		 	expect(player.ships.select(&submarine)).not_to be_empty
		end

		it "should have 1 tug" do
		 	tug = lambda {|ship| ship.class == Tug}
		 	expect(player.ships.select(&tug)).not_to be_empty
		end

		# it "should have a home grid" do 
		# 	expect(player.home_grid).not_to be_nil
		# end

		# it "should have a tracking grid" do 
		# 	expect(player.tracking_grid).not_to be_nil
		# end
	
	end
	
	context "playing the game" do

		it "will choose the relevant ship by inputting a given string" do 
			ship = "aircraftcarrier"
			expect(player.chosen(ship)).to eq(player.aircraftcarrier)
		end

		it "will choose the relevant ship by inputting a given string" do 
			ship = "battleship"
			expect(player.chosen(ship)).to eq(player.battleship)
		end
		
		it "will choose the relevant ship by inputting a given string" do 
			ship = "submarine"
			expect(player.chosen(ship)).to eq(player.submarine)
		end

		it "should specify a starting coordinate" do
			coordinate = "A1"
			expect(player.specified(coordinate).display).to eq "(1,1)"
		end

		it "specifying A10 will display a coordinate (1,10)" do 
			coordinate = "A10"
			expect(player.specified(coordinate).display).to eq "(1,10)"
		end
			

		it "should specify the vertical orientation" do
			ship = player.submarine
			orientation = "vertical"
			player.set(ship, orientation)
			expect(ship.horizontal?).to be_false
		end

		it "should specify the vertical orientation" do
			ship = player.submarine
			orientation = "horizontal"
			player.set(ship, orientation)
			expect(ship.horizontal?).to be_true
		end

		it "can place a ship on the grid" do
			player.place("tug","A1", "vertical")
			carrier = []
			player.tug.locations.each {|location| carrier << location.display}
			expect(carrier).to eq ["(1,1)", "(2,1)"]
		end

		# it "no longer has that ship after placing the ship" do 
		# 	player.place("tug", "A1", "vertical")
		# 	player.place("tug", "B6", "vertical")
		# 	expect(player.tug.locations[2].original_string).not_to eq "B6"
		# end

		it "can target a coordinate that already exists" do 
			coordinate = Coordinate.new("A","1")
			player.target("A1")
			expect(coordinate.targeted?).to be_true
		end

		it "can target a coordinate that doesn't exist" do 
			Coordinate.existing_coordinates.clear
			Coordinate.new("B", "2")
			player.target("A1")
			a1 = Coordinate.existing_coordinates.select {|location| location.original_string == "A1"}
			expect(a1).not_to be_empty
		end
	
	end


end