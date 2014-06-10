require 'player'
require 'coordinate'
# require 'game'

describe Player do

	let(:game) {Game.new}
	let (:player) {game.player1	}
	before {player.defending_coordinates.existing_coordinates.clear}

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
			Player2HomeCoordinate.existing_coordinates.clear
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

	context "rules for playing" do 
		it "will not allow a player to place the same ship more than once" do 
			player.place("destroyer", "A1")
			player.place("destroyer", "D1")
			destroyer_loc = []
			player.destroyer.locations.each {|location| destroyer_loc << location.display}
			expect(destroyer_loc).not_to include "(4,1)"
		end

		it "will not allow a player to place a ship out of boundaries" do 
			destroyer_loc = []
			player.destroyer.locations.each {|location| destroyer_loc << location.display}
			expect(lambda{player.place("destroyer", "Z11")}).to raise_error
			expect(destroyer_loc).to be_empty
		end

		it "cannot place a ship on the same spot as another ship" do 
			player.place("destroyer", "A1")
			player.place("aircraftcarrier", "A1")
			expect(player.aircraftcarrier.locations[0].display).not_to eq "(1,1)"
		end

		it "will not allow a player to target the same coordinate twice" do 
			Player2HomeCoordinate.existing_coordinates.clear
			opponent = Player.new("will", false)
			opponent.place("destroyer", "C8")
			player.target("A1")
			expect(player.target("A1")).to eq "You already hit that bro"
		end

		it "does not return the error message by default" do 
			Player2HomeCoordinate.existing_coordinates.clear
			game.player2.place("destroyer", "C8")
			expect(player.target("D9")).not_to eq "You already hit that bro"
		end
	end


end