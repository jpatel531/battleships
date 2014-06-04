require 'player'

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
	
	end
	
	context "playing the game" do
		
		it "can place a ship on the grid" do
			
			player.place_ship("aircraft_carrier","A1", "vertical")
			expect(self.)

		end
	
	end


end