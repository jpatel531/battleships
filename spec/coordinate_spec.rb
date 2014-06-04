require 'coordinate'

describe Coordinate do 
	let(:coordinate) {Coordinate.new("a","1")}
	let(:ship) {Ship.new}

	it "is untargeted when initialized" do 
		expect(coordinate.targeted?).to be_false
	end

	it "has a row and column when initialized" do
		expect(coordinate.row).to eq 1
		expect(coordinate.column).to eq 1
	end

	it "B1 has a row value of 2 and column 1" do
		coordinate = Coordinate.new("B", "1")
		expect(coordinate.row).to eq 2
		expect(coordinate.column).to eq 1
	end

	it "can pass in numbers when initialized" do
		coordinate = Coordinate.new(1,2) 
		expect(coordinate.row).to eq 1
		expect(coordinate.column).to eq 2
	end

	context "interactions with ship" do  
		let(:ship) {Ship.new}
		let(:a1) {Coordinate.new(1,1)}
		before(:each){a1.hold ship}

		it "can hold a ship" do
			expect(ship.locations).to include(a1)
		end

		it "confirms that a ship is present" do
			expect(a1).to have_ship
		end

		it "confirms when a ship is not present" do
			C3 = Coordinate.new("C", "3")
			expect(C3).not_to have_ship
		end
	end

	it "knows when it's been targeted" do
		a1 = Coordinate.new("A", "1")
		a1.targeted = true
		expect(a1).to be_targeted
  end

end