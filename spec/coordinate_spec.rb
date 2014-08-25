require 'coordinate'
require 'game'

describe Coordinate do 
	let(:coordinate) {Player1HomeCoordinate.new("a","1")}
	let(:ship) {Ship.new}

	it "is untargeted when initialized" do 
		expect(coordinate.targeted?).to be_falsey
	end

	it "has a row and column when initialized" do
		expect(coordinate.row).to eq 1
		expect(coordinate.column).to eq 1
	end

	it "B1 has a row value of 2 and column 1" do
		coordinate = Player1HomeCoordinate.new("B", "1")
		expect(coordinate.row).to eq 2
		expect(coordinate.column).to eq 1
	end

	it "can pass in numbers when initialized" do
		coordinate = Player1HomeCoordinate.new(1,2) 
		expect(coordinate.row).to eq 1
		expect(coordinate.column).to eq 2
	end

	it "can display a pretty version of itself" do 
		expect(coordinate.display).to eq "(1,1)"
	end


	context "bla bla" do 

	it "is added to a list of members of the Coordinate class" do
		Player1HomeCoordinate.existing_coordinates.clear
		c4 = Player1HomeCoordinate.new("C", "4")
		expect(Player1HomeCoordinate.existing_coordinates).to eq [c4]
	end

	end

	context "interactions with ship" do  
		let(:ship) {Ship.new}
		let(:a1) {Player1HomeCoordinate.new(1,1)}
		before(:each){a1.hold ship}

		it "can hold a ship" do
			expect(ship.locations).to include(a1)
		end

		it "confirms that a ship is present" do
			expect(a1).to have_ship
		end

		it "confirms when a ship is not present" do
			C3 = Player1HomeCoordinate.new("C", "3")
			expect(C3).not_to have_ship
		end
	end

	it "knows when it's been targeted" do
		a1 = Player1HomeCoordinate.new("A", "1")
		a1.targeted = true
		expect(a1).to be_targeted
  end

  it "knows when a ship is missed" do
  	a1 = Player1HomeCoordinate.new(1,1)
  	a1.targeted = true
  	expect(a1).to be_miss
  end

  it "says a ship is not missed when it is hit" do
  	a1 = Player1HomeCoordinate.new(1,1)
    ship = Ship.new 
  	a1.hold ship 
  	a1.targeted = true
  	expect(a1).not_to be_miss 
  	expect(a1).to be_hit
  end

  context "Coordinate subclasses" do 
  	let(:game) {Game.new}

  	it "only register members of its own class in the existing_coordinates array" do 
  			game.player1.place("destroyer", "A1")
  			game.player2.place("aircraftcarrier", "E2")
  			other_class = lambda {|location| location.is_a? Player1HomeCoordinate}
  			other_class_members = Player2HomeCoordinate.existing_coordinates.select(&other_class)
  			expect(other_class_members).to be_empty
  	end

  end

end