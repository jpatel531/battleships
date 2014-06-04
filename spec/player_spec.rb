require 'player'

describe Player do

	let (:player) {Player.new("Tron")}

	it "should have 1 aircraft carrier when starting the game" do
	 aircraft_carrier = lambda {|ship| ship.class == AircraftCarrier}
	 expect(player.ships.select(&aircraft_carrier)).not_to be_empty
	end

	it "always has the same aircraft carrier" do 
		 aircraft_carrier = lambda {|ship| ship.class == AircraftCarrier}
		 carrier1 = player.ships.select(&aircraft_carrier)
		 carrier2 = player.ships.select(&aircraft_carrier)
		 expect(carrier1).to eq carrier2
	end

	it "should have 1 battleship when starting the game" do
	 	battleship = lambda {|ship| ship.class == Battleship}
	 	expect(player.ships.select(&battleship)).not_to be_empty
	end

	it "should have 1 destroyer when starting the game" do
	 	destroyer = lambda {|ship| ship.class == Destroyer}
	 	expect(player.ships.select(&destroyer)).not_to be_empty
	end

	it "should have 1 submarine when starting the game" do
	 	submarine = lambda {|ship| ship.class == Submarine}
	 	expect(player.ships.select(&submarine)).not_to be_empty
	end

	it "should have 1 tug when starting the game" do
	 	tug = lambda {|ship| ship.class == Tug}
	 	expect(player.ships.select(&tug)).not_to be_empty
	end

end