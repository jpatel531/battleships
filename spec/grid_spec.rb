require 'grid'
require 'game'

include Game

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
		grid.mark_ships_of(player)
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

	# it "can mark sunken ships" do 
	# 	player.place("destroyer", "A1")
	# 	opponent.target("A1") ; opponent.target("A2") ; opponent.target("A3")
	# 	grid.mark_sinks_to player
	# 	expect(grid.display[0][0]).to eq ":("
	# 	expect(grid.display[0][1]).to eq ":("
	# 	expect(grid.display[0][2]).to eq ":("
	# end

context "the conditional viewer" do 
	let(:home_grid) {Player1HomeGrid.new}
	before(:each) { Coordinate.existing_coordinates.clear
		PLAYER1.place("destroyer", "A1")}

	it "player 2 cannot see the ships of player 1's home grid" do 
		home_grid.update_for(PLAYER2)
		expect(home_grid.display[0][0]).to be_nil
	end

	it "both player 1 and player 2 can see player 2's misses" do 
		PLAYER2.target("E8")
		home_grid.update_for(PLAYER1)
		expect(home_grid.display[4][7]).to eq "M"
		home_grid.update_for(PLAYER2)
		expect(home_grid.display[4][7]).to eq "M"
	end

	it "both player 1 and player 2 can see player 1's hit ships" do 
		PLAYER2.target("A1")
		home_grid.update_for(PLAYER1)
		expect(home_grid.display[0][0]).to eq "H"
		home_grid.update_for(PLAYER2)
		expect(home_grid.display[0][0]).to eq "H"
	end

	# it "both player 1 and player 2 can see player 1's sunken ships" do 
	# 	PLAYER2.target("A1") ; PLAYER2.target("A2") ; PLAYER2.target("A3") 
	# 	home_grid.update_for(PLAYER1)
	# 	expect(home_grid.display[0][0]).to eq ":("
	# 	expect(home_grid.display[0][1]).to eq ":("
	# 	expect(home_grid.display[0][2]).to eq ":("
	# 	home_grid.update_for(PLAYER2)
	# 	expect(home_grid.display[0][0]).to eq ":("
	# 	expect(home_grid.display[0][1]).to eq ":("
	# 	expect(home_grid.display[0][2]).to eq ":("
	# end

end

end