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


		it "is player 1's turn" do 
			expect(game.current_player).to eq game.player1
		end

		it "allows it to be player2's turn" do 
			game.switch_player
			expect(game.current_player).to eq game.player2
		end
	end


	context "placing ships" do 

		it "stops adding player 1's ships when all his ships are placed" do 
			game.player1.place("destroyer", "A1") 
			game.player1.place("aircraftcarrier", "B1") 
			game.player1.place("submarine", "C1") 
			game.player1.place("battleship", "D1") 
			game.player1.place("tug", "E1")
			expect(game.player1).not_to receive(:place)
			game.turn_to_place("battleship", "E1")
		end

		it "then allows player 2 to place his ships after player 1" do 			
			puts "Hello"
			game.player1.place("destroyer", "A1") 
			game.player1.place("aircraftcarrier", "B1") 
			game.player1.place("submarine", "C1") 
			game.player1.place("battleship", "D1") 
			game.player1.place("tug", "E1")
			expect(game.player2).to receive(:place)
			game.turn_to_place("destroyer", "A1")
		end

	end

	context "targeting ships" do 
		before {Player2HomeCoordinate.existing_coordinates.clear}

		it "allows player2 to target a coordinate after player 1 has done so" do
			game.turn_to_target("A1")
			expect(game.player2).to receive(:target)
			game.turn_to_target("A1")
		end

		it "if you already hit that you get to retake your go" do 
			game.player1.target("A1")
			game.turn_to_target("A1")
			expect(game.current_player).to eq game.player1
		end

		it "if you have hit a ship, you get another go" do 
			game.player2.place("destroyer", "A1")
			game.turn_to_target("A1")
			expect(game.current_player).to eq game.player1
		end

	end
end