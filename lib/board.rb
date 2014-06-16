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
	property :player1, Object
	property :player2, Object
	property :player1grid, Object
	property :player2grid, Object
end

DataMapper.finalize.auto_upgrade! 

get '/' do 
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
	redirect "/game" if User.count == 2
	erb :wait
end

get '/success/' do 
	play = PlayTime.create(:name => 'Hello', :game => Game.new)
	@game = play.game
	play.update(:player1 => @game.player1)
	play.update(:player2 => @game.player2)
	play.update(:player1grid => @game.player1_home_grid)
	play.update(:player2grid => @game.player2_home_grid)
	redirect '/game'
end

get '/destroy' do 
	User.destroy
end

get '/game' do
	play = PlayTime.first(:name =>'Hello')
	@homegrid = play.player1grid if session[:number] == 1
	@homegrid = play.player2grid if session[:number] == 2
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


get '/game/coordinate/:coordinate' do 
	play = PlayTime.first(:name => 'Hello')
	redirect '/game' if session[:ship].nil?
	if session[:number] == 1
		play.player1.place(session[:ship], params[:coordinate], session[:orientation])	
	else
		play.player2.place(session[:ship], params[:coordinate], session[:orientation])
	end
	if session[:number] == 1
		play.game.player1_home_grid.update_for(play.player1)
		play.update(:player1grid => play.game.player1_home_grid)
	else
		play.game.player2_home_grid.update_for(play.player2)
		play.update(:player2grid => play.game.player2_home_grid)
	end
	session[:ship] = nil
	session[:orientation] = nil
	redirect '/game'
end