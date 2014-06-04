require 'ship_types'

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

describe Destroyer do
	let(:submarine) {Submarine.new}

	it "has a length of 3" do 
		expect(submarine.length).to eq 3
	end
end

describe Tug do
	let(:tug) {Tug.new}

	it "has a length of 2" do 
		expect(tug.length).to eq 2
	end
end