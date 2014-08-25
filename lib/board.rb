require 'sinatra'
require_relative 'app'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/main.db")
set :public, Proc.new {File.join(root, '..', "public")}
enable :sessions

class User
	include DataMapper::Resource
	property :id, Serial
	property :name, Text, required: true
	property :number, Integer
end

class PlayTime
	include DataMapper::Resource
	property :id, Serial
	property :name, Text
	property :game, Object
	property :turn, Integer, default: 1
	property :p1targets, Text
	property :p2targets, Text
end

DataMapper.finalize.auto_upgrade! 

get '/' do 
	redirect '/game' if !session[:player].nil?
	erb :index
end

post '/' do 
	if User.count == 0
		@player1 = User.create(:name => params[:name], :number => 1)
		session[:number] = 1
		redirect '/wait/'
	else
		@player2 = User.create(:name => params[:name], :number => 2)
		session[:number] = 2
		redirect '/success/'
	end
end

get '/wait/' do
	redirect '/success/' if User.count == 2
	erb :wait
end

get '/success/' do 
	play = PlayTime.create(:name => 'Hello', :game => Game.new)
	session[:game] = play.game
	@game = session[:game]
	if session[:number] == 1
		session[:homegrid] = @game.player1_home_grid
		session[:targetgrid] = @game.player2_home_grid
		session[:player] = @game.player1
		session[:opponent] = @game.player2
	elsif session[:number] == 2
		session[:homegrid] = @game.player2_home_grid
		session[:targetgrid] = @game.player1_home_grid
		session[:player] = @game.player2
		session[:opponent] = @game.player1
	end
	redirect '/game'
end

get '/destroy' do 
	User.destroy
	PlayTime.destroy
	session.clear
end

get '/game' do
	play = PlayTime.first(name: 'Hello')
	if !play.p1targets.nil? || !play.p2targets.nil?
		if session[:number] == 1
			session[:opponent].target(play.p2targets)
		elsif session[:number] == 2
			session[:opponent].target(play.p1targets)
		end
	session[:targetgrid].update_for(session[:player])
	end
	session[:turn] = play.turn
	erb :board
end

get '/game/ship/:ship' do 
	session[:ship] ||= params[:ship]
	redirect '/game'
end

get '/game/orientation/:orientation' do 
	session[:orientation] ||= params[:orientation]
	redirect '/game'
end

get '/game/place/:coordinate' do 
	@game = session[:game]
	redirect '/game' if session[:ship].nil?
	session[:player].place(session[:ship], params[:coordinate], session[:orientation])	
	session[:homegrid].update_for(session[:player])
	session[:ship] = nil
	session[:orientation] = nil
	redirect '/game'
end

get '/game/target/:coordinate' do 
	play = PlayTime.first(name: 'Hello')
	if session[:number] == 1 && play.turn == 1 && session[:player].all_deployed?
		play.p1targets = params[:coordinate]
		play.turn = 2
		play.save
	elsif session[:number] == 2 && play.turn == 2 && session[:player].all_deployed?
		play.p2targets = params[:coordinate]
		play.turn = 1
		play.save
	end
	redirect '/game'
end












