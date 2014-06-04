require 'ship'

describe Ship do 
	let(:ship) {Ship.new() }


	context "when initialized" do 

		it "has a set length" do 
			expect(ship.length).to eq 3
		end

		it "is not hit" do
			B1 = double :B1, targeted?: false
			ship.locations << B1
			expect(ship.hit_locations).to be_empty
		end

		it "is horizontal by default" do 
			expect(ship.horizontal?).to be_true
		end

	end

	context "when placed by player" do 

		it "has a start location" do
			player = double :player, place_ship: ship.locations << :A1 
			player.place_ship
			expect(ship.locations).to eq [:A1]
		end

		it "can be placed vertically" do
			# player = double :player, place_vertically: 
			ship.place_vertically!
			expect(ship).not_to be_horizontal
		end

		it "should occupy adjacent coordinates if horizontal" do 
			a1 = Coordinate.new(1,1)
			a1.hold(ship)
			ship.extend_coordinates
			expect(ship.locations[1].display).to eq "(1,2)"
			expect(ship.locations[2].display).to eq "(1,3)"
		end

		it "should not occupy more coordinates than is length" do 
			a1 = Coordinate.new(1,1)
			a1.hold(ship)
			ship.extend_coordinates
			expect(ship.locations[1].display).to eq "(1,2)"
			expect(ship.locations[2].display).to eq "(1,3)"
			expect(ship.locations[3].display).to eq nil
		end

		it "should occupy adjacent coordinates if vertical" do 
			a1 = Coordinate.new(1,1)
			a1.hold(ship)
			ship.place_vertically!
			ship.extend_coordinates
			expect(ship.locations[1].display).to eq "(2,1)"
			expect(ship.locations[2].display).to eq "(3,1)"
		end


	end

	context "knows" do 

		before {A1 = double :A1, targeted?: true}

		it "where it's been hit" do
			ship.locations << A1
			expect(ship.hit_locations).to eq [A1]
		end

		it "when it's been sunk" do 
			A2 = double :A2, targeted?: true
			A3 = double :A3, targeted?: true
			ship.locations << A1 ; ship.locations << A2 ; ship.locations << A3
			expect(ship.sunk?).to be_true
		end
	end
end

describe AircraftCarrier do 
	let(:aircraft_carrier) {AircraftCarrier.new}

		it "has a length of 5" do 
			expect(aircraft_carrier.length).to eq 5
		end
end

describe Battleship do
	let(:battleship) {Battleship.new}

	it "has a length of 4" do 
		expect(battleship.length).to eq 4
	end
end

describe Destroyer do
	let(:destroyer) {Destroyer.new}

	it "has a length of 3" do 
		expect(destroyer.length).to eq 3
	end
end

describe Tug do
	let(:tug) {Tug.new}

	it "has a length of 2" do 
		expect(tug.length).to eq 2
	end
end

