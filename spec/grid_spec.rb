require 'grid'
require 'matrix'

describe Grid do 
	let(:grid) {Grid.new}
	let(:player) {Player.new("jamie")}
	let(:opponent) {Player.new("steve")}

	it "is built as an array" do 
		expect(grid.display).to be_kind_of(Array)
	end

	it "is built as a 10x10 matrix" do 
		expect(grid.display.count).to eq 10
		expect(grid.display[0].count).to eq 10
	end

	it "can show where a ship has been placed" do 
		player.place("destroyer", "A1")
		grid.mark_ships_from(Coordinate)
		expect(grid.display[0][0]).to eq "S"
	end

	it "can show where a ship has been hit" do 
		player.place("destroyer", "A1")
		opponent.target("A1")
		grid.mark_hits_to player
		expect(grid.display[0][0]).to eq "H"
	end

	it "can show where a player has hit sea" do 
		player.target("A1")
		grid.mark_misses_from(Coordinate)
		expect(grid.display[0][0]).to eq "M"
	end

	it "can mark sunken ships" do 
		player.place("destroyer", "A1")
		opponent.target("A1") ; opponent.target("A2") ; opponent.target("A3")
		grid.mark_sinks_to player
		expect(grid.display[0][0]).to eq ":("
		expect(grid.display[0][1]).to eq ":("
		expect(grid.display[0][2]).to eq ":("
	end

end