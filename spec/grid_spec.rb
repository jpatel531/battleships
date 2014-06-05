require 'grid'
require 'matrix'

describe Grid do 
	let(:grid) {Grid.new}
	let(:player) {Player.new("jamie")}

	it "is built as a matrix" do 
		expect(grid.build).to be_kind_of(Matrix)
	end

	it "is built as a 10x10 matrix" do 
		expect(grid.build.column_size).to eq 10
		expect(grid.build.row_size).to eq 10 
	end

	it "can show where a ship has been placed" do 
		player.place("destroyer", "A1")
		grid.draw_from(Coordinate)
		expect(grid.build.[](0,0)).to eq "S"

	end


end