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
		before(:each) {game.player1.defending_coordinates.existing_coordinates.clear}

		it "stops adding player 1's ships when all his ships are placed" do 
			game.stub(:ship).and_return("aircraftcarrier")
			game.stub(:coordinate).and_return("E1")
			game.stub(:orientation).and_return("horizontal")
			ships = %w(destroyer submarine tug battleship)
			coordinates = %w(A1 B1 C1 D1)
			ships.each_with_index { |ship, index| game.player1.place(ship, coordinates[index]) }
			expect(game).to receive(:switch_player)
			game.turn_to_place
			expect(game.player1).to be_all_deployed
		end

		it "then allows player 2 to place his ships after player 1 has done so " do 			
			game.stub(:ship).and_return("battleship")
			game.stub(:coordinate).and_return("A1")
			game.stub(:orientation).and_return(" ")
			ships = %w(destroyer submarine tug battleship aircraftcarrier)
			coordinates = %w(A1 B1 C1 D1 E1)
			ships.each_with_index { |ship, index| game.player1.place(ship, coordinates[index]) }
			expect(game.player2).to receive(:place)
			game.turn_to_place
		end

	end

	context "targeting ships" do 
		before {Player2HomeCoordinate.existing_coordinates.clear}

		it "allows player2 to target a coordinate after player 1 has done so" do
			game.stub(:coordinate).and_return("A1")
			expect(game).to receive(:switch_player)
			game.target_round
		end

		it "if you already targeted it you get to retake your go" do 
			game.current_player = game.player1
			game.player2.place("destroyer", "G6")
			game.player1.target("A1")
			game.stub(:coordinate).and_return("A1", "B1")
			game.target_round
			b1 = Player2HomeCoordinate.existing_coordinates.select {|location| location.original_string == "B1"}
			expect(b1).not_to be_empty
		end

		it "if you have hit a ship, you get another go" do 
			game.current_player = game.player1
			game.player2.place("destroyer", "A1")
			game.player1.target("A1")
			game.stub(:coordinate).and_return("B1")
			game.target_round
			missed_b1 = Player2HomeCoordinate.existing_coordinates.select {|location| (location.miss?) && (location.original_string == "B1")}
			expect(missed_b1).not_to be_empty
		end
	end

	context "finishing the game" do 
		it "reports a victor" do 
			Player2HomeCoordinate.existing_coordinates.clear
			ships = %w(destroyer submarine tug battleship aircraftcarrier)
			coordinates = %w(A1 B1 C1 D1 E1)
			ships.each_with_index { |ship, index| game.player2.place(ship, coordinates[index]) }
			target_co = %w(A1 A2 A3 A4 A5 B1 B2 B3 B4 B5 C1 C2 C3 C4 C5 D1 D2 D3 D4 D5 E1 E2 E3 E4 E5)
			target_co.each {|co| game.player1.target(co)}
			expect(game.player2).to be_loser
			expect(game.victor).to eq game.player1
		end

	end

end