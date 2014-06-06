require 'ship'

describe Ship do 
	let(:ship) {Ship.new() }
	let(:player) {Player.new("Jamie")}


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
			ship.horizontal = false
			expect(ship).not_to be_horizontal
		end

		it "should occupy adjacent coordinates if horizontal" do 
			player.place("destroyer", "A1")
			expect(player.destroyer.locations[1].display).to eq "(1,2)"
			expect(player.destroyer.locations[2].display).to eq "(1,3)"
		end

		it "should not occupy more coordinates than is length" do 
			player.place("destroyer", "A1")
			expect(player.destroyer.locations[1].display).to eq "(1,2)"
			expect(player.destroyer.locations[2].display).to eq "(1,3)"
			expect(player.destroyer.locations[3].display).to eq nil
		end

		it "should occupy adjacent coordinates if vertical" do 
			player.place("destroyer", "A1", "vertical")
			expect(player.destroyer.locations[1].display).to eq "(2,1)"
			expect(player.destroyer.locations[2].display).to eq "(3,1)"
			expect(player.destroyer.locations[3].display).to eq nil
		end

		it "adjacent coordinates should also know they have a ship" do 
			player.place("destroyer", "A1")
			expect(player.destroyer.locations[1]).to have_ship
			expect(player.destroyer.locations[2]).to have_ship
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

