require 'grid'
require 'game'

include Game

describe Grid do 
	let(:grid) {Player1HomeGrid.new}
	let(:player) {PLAYER1}
	let(:opponent) {PLAYER2}

	it "is built as an array" do 
		expect(grid.display).to be_kind_of(Array)
	end

	it "is built as a 10x10 matrix" do 
		expect(grid.display.count).to eq 10
		expect(grid.display[0].count).to eq 10
	end

	it "can show where a ship has been placed" do 
		player.place("destroyer", "A1")
		grid.mark_ships
		expect(grid.display[0][0]).to eq "S"
		expect(grid.display[0][1]).to eq "S"
		expect(grid.display[0][2]).to eq "S"
	end

	it "can show where a ship has been hit" do 
		player.place("destroyer", "A1")
		opponent.target("A1")
		grid.mark_hits
		expect(grid.display[0][0]).to eq "H"
	end

	it "can show where a player has hit sea" do 
		player.target("A1")
		grid.mark_misses
		expect(grid.display[0][0]).to eq "M"
	end


	context "the conditional viewer: Player 1's Home Grid" do 
		let(:home_grid) {Player1HomeGrid.new}
		before(:each) { Player1HomeCoordinate.existing_coordinates.clear
			PLAYER1.place("destroyer", "A1")}

		it "player 2 cannot see the ships of player 1's home grid" do 
			grid.update_for(PLAYER2)
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
	end

	context "the conditional viewer: Player 2's Home Grid" do  
		let(:home_grid) {Player2HomeGrid.new}
		before(:each) {Player2HomeCoordinate.existing_coordinates.clear
									PLAYER2.place("destroyer", "A1")}

		it "player 1 cannot see the ships of player 2's home grid" do 
			grid.update_for(PLAYER1)
			expect(home_grid.display[0][0]).to be_nil
		end

		it "both player 1 and player 2 can see player 1's misses" do 
			PLAYER1.target("E8")
			home_grid.update_for(PLAYER1)
			expect(home_grid.display[4][7]).to eq "M"
			home_grid.update_for(PLAYER2)
			expect(home_grid.display[4][7]).to eq "M"
		end

		it "both player 1 and player 2 can see player 2's hit ships" do 
			PLAYER1.target("A1")
			home_grid.update_for(PLAYER2)
			expect(home_grid.display[0][0]).to eq "H"
			home_grid.update_for(PLAYER1)
			expect(home_grid.display[0][0]).to eq "H"
		end

end

end