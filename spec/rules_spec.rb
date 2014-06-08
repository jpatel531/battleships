require 'grid'
require 'rules'

include Rules

describe Grid do 
	let(:grid) {Player1HomeGrid.new}
	let(:player) {PLAYER1}
	let(:opponent) {PLAYER2}

	context "when initialized" do

		it "is an array" do 
			expect(grid.display).to be_kind_of(Array)
		end

		it "is a 10x10 array" do 
			expect(grid.display.count).to eq 10
			expect(grid.display[0].count).to eq 10
		end
	end

	context "can show a ship's" do 
		before {player.place("destroyer", "A1")}

		it "location" do 
			grid.mark_ships
			expect(grid.display[0][0,3]).to eq ["S","S","S"]
		end

		it "hits" do 
			opponent.target("A1")
			grid.mark_hits
			expect(grid.display[0][0]).to eq "H"
		end
	end

	context "can show a player's" do 

		it "misses" do 
			player.target("A1")
			grid.mark_misses
			expect(grid.display[0][0]).to eq "M"
		end

	end

	describe "the conditional viewer" do 
		let(:grid1) {Player1HomeGrid.new}
		let(:grid2) {Player2HomeGrid.new}
		before(:each) do
			Player1HomeCoordinate.existing_coordinates.clear
			PLAYER1.place("destroyer", "A1")
			Player2HomeCoordinate.existing_coordinates.clear
			PLAYER2.place("destroyer", "A1")
		end


		it "player 2 cannot see the ships of player 1's home grid" do 
			grid1.update_for(PLAYER2)
			expect(grid1.display[0][0]).not_to eq "S"
			grid2.update_for(PLAYER1)
			expect(grid2.display[0][0]).not_to eq "S"
		end

		it "both player 1 and player 2 can see player 2's misses" do 
			PLAYER1.target("E8") ; PLAYER2.target("E8")
			grid1.update_for(PLAYER1)
			expect(grid1.display[4][7]).to eq "M"
			grid1.update_for(PLAYER2)
			expect(grid1.display[4][7]).to eq "M"
			grid2.update_for(PLAYER1)
			expect(grid2.display[4][7]).to eq "M"
			grid2.update_for(PLAYER2)
			expect(grid2.display[4][7]).to eq "M"
		end

		it "both player 1 and player 2 can see player 1's hit ships" do 
			PLAYER1.target("A1")
			PLAYER2.target("A1")
			grid1.update_for(PLAYER1)
			expect(grid1.display[0][0]).to eq "H"
			grid1.update_for(PLAYER2)
			expect(grid1.display[0][0]).to eq "H"
			grid2.update_for(PLAYER2)
			expect(grid2.display[0][0]).to eq "H"
			grid2.update_for(PLAYER1)
			expect(grid2.display[0][0]).to eq "H"
		end
	end


end