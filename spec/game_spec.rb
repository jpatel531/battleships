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
			game.turn_to_place(game.player1)
		end

		it "then allows player 2 to place his ships after player 1" do 			
			# game.player1.place("destroyer", "A1") 
			# game.player1.place("aircraftcarrier", "B1") 
			# game.player1.place("submarine", "C1") 
			# game.player1.place("battleship", "D1") 
			# game.player1.place("tug", "E1")
			# game.stub(:place_ship).with(game.player2).and_return(true)
			# expect(game.player2).to receive(:place)
			# game.placing_round
		end

		it "will not allow a player to place the same ship more than once" do 
			game.player1.place("destroyer", "A1")
			game.player1.place("destroyer", "D1")
			destroyer_loc = []
			game.player1.destroyer.locations.each {|location| destroyer_loc << location.display}
			expect(destroyer_loc).not_to include "(4,1)"
		end

		it "will not allow a player to place a ship out of boundaries" do 
			# game.player1.place("destroyer", "Z11")
			destroyer_loc = []
			game.player1.destroyer.locations.each {|location| destroyer_loc << location.display}
			expect(lambda{game.player1.place("destroyer", "Z11")}).to raise_error
			expect(destroyer_loc).to be_empty
		end
	end
end