require 'sinatra'
require_relative 'app'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/users.db")
set :public, Proc.new {File.join(root, '..', "public")}
enable :sessions

class User
	include DataMapper::Resource
	property :id, Serial
	property :name, Text, required: true
end

DataMapper.finalize.auto_upgrade! 

get '/' do 
	erb :index
end

post '/' do 
	if User.count == 0
		@player1 = User.new
		@player1.name = params[:name]
		@player1.save
		redirect '/1/wait/'
	else
		@player2 = User.new
		@player2.name = params[:name]
		@player2.save
		redirect '/2/game'
	end
end

get '/:num/wait/' do |num|
	@users = User.all :order => :id.desc
	redirect "/#{num}/game" if @users.count == 2
	erb :wait
end

get '/destroy' do 
	User.destroy
end

get '/:num/game' do
	session[:num] = params[:num]
	session[:game] ||= Game.new
	@game = session[:game]
	session[:player] = (params[:num] == 1) ? @game.player1 : @game.player2
	@player = session[:player]
	session[:grid] = (params[:num] == 1) ? @game.player1_home_grid : @game.player2_home_grid
	@grid = session[:grid]
	erb :board
end

get '/:num/game/ship/:ship' do 
	session[:ship] ||= params[:ship]
	redirect "/#{params[:num]}/game"
end

get '/:num/game/orientation/:orientation' do 
	session[:orientation] ||= params[:orientation]
	redirect '/#{params[:num]}/game'
end


get '/:num/game/coordinate/:coordinate' do 
	redirect "/#{params[:num]}/game" if session[:ship].nil?
	@game = session[:game]
	session[:player].place(session[:ship], params[:coordinate], session[:orientation])	
	session[:grid].update_for(session[:player])
	session[:ship] = nil
	session[:orientation] = nil
	redirect "/#{params[:num]}/game"
end