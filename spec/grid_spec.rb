require 'grid'
require 'game'
require 'grid_types'


describe Grid do 
	let(:game) {Game.new}
	let(:player) {game.player1}
	let(:opponent) {game.player2}
	let(:grid) {Player1HomeGrid.new(game.player1)}

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
			grid.mark(:ships)
			expect(grid.display[0][0,3]).to eq ["S","S","S"]
		end

		it "hits" do 
			opponent.target("A1")
			grid.mark(:hits)
			expect(grid.display[0][0]).to eq "H"
		end
	end

	context "can show a player's" do 

		it "misses" do 
			player.target("A1")
			grid.mark_misses
			expect(grid.display[0][0]).to eq "M"
		end

		it "won't show a miss by default" do 
			Player1HomeCoordinate.existing_coordinates.clear
			grid.update_for player
			expect(grid.display[0][0]).not_to eq "M"
		end		

	end

	describe "the conditional viewer" do 
		let(:game) {Game.new}
		let(:grid1) {game.player1_home_grid}
		let(:grid2) {game.player2_home_grid}
		let(:player) {game.player1}
		let(:opponent) {game.player2}
		before(:each) do
			Player1HomeCoordinate.existing_coordinates.clear
			player.place("destroyer", "A1")
			Player2HomeCoordinate.existing_coordinates.clear
			opponent.place("destroyer", "A1")
		end


		it "player 2 cannot see the ships of player 1's home grid" do 
			grid1.update_for(opponent)
			expect(grid1.display[0][0]).not_to eq "S"
			grid2.update_for(player)
			expect(grid2.display[0][0]).not_to eq "S"
		end

		it "both player 1 and player 2 can see player 2's misses" do 
			player.target("E8") ; opponent.target("E8")
			grid1.update_for(player)
			expect(grid1.display[4][7]).to eq "M"
			grid1.update_for(opponent)
			expect(grid1.display[4][7]).to eq "M"
			grid2.update_for(player)
			expect(grid2.display[4][7]).to eq "M"
			grid2.update_for(opponent)
			expect(grid2.display[4][7]).to eq "M"
		end

		it "both player 1 and player 2 can see player 1's hit ships" do 
			player.target("A1")
			opponent.target("A1")
			grid1.update_for(player)
			expect(grid1.display[0][0]).to eq "H"
			grid1.update_for(opponent)
			expect(grid1.display[0][0]).to eq "H"
			grid2.update_for(opponent)
			expect(grid2.display[0][0]).to eq "H"
			grid2.update_for(player)
			expect(grid2.display[0][0]).to eq "H"
		end
	end


end