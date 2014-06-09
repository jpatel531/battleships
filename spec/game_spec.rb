require 'game'

describe Game do
	let(:game) {Game.new}

	context "when initialized" do 

		it "has 2 players" do 
			expect(game.player1).to be_kind_of Player
			expect(game.player2).to be_kind_of Player
		end

		it "has 2 grids" do 
			expect(game.player1_home_grid).to be_kind_of Grid
			expect(game.player2_home_grid).to be_kind_of Grid
		end
	end

	context "placing ships" do 

		it "allows player 1 to place his ship" do 
			game.stub(:ship).and_return("destroyer")
			game.stub(:coordinate).and_return("A1")
			game.stub(:orientation).and_return("vertical")
			expect(game.player1).to receive(:place).with("destroyer", "A1", "vertical")
			game.place_ship(game.player1)
		end

		it "stops adding player 1's ships when all his ships are placed" do 
			game.player1.place("destroyer", "A1") 
			game.player1.place("aircraftcarrier", "B1") 
			game.player1.place("submarine", "C1") 
			game.player1.place("battleship", "D1") 
			game.player1.place("tug", "E1")
			expect(game.player1).not_to receive(:place)
			game.placing_round
		end

		# it "then allows player 2 to place his ships after player 1" do 
		# 	expect(game).to receive(:turn_to_place).with(game.player1)
		# 	expect(game).to receive(:turn_to_place).with(game.player2)
		# 	game.placing_round
		# end

		# it "will not allow a player to place the same ship more than once" do 
		# 	game.player1.place("destroyer", "A1")
		# 	game.stub(:input).and_return("destroyer", "A1", "horizontal")
		# 	expect(lambda {game.place_ship(game.player1)}).to raise_error
		# end
	end
end