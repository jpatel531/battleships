require 'sinatra'
require_relative 'app'

set :public, Proc.new {File.join(root, '..', "public")}
enable :sessions

get '/' do 
	"Hello World"
end

get '/game' do
	session[:game] ||= Game.new
	@game = session[:game]
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
	redirect '/game' if session[:ship].nil?
	@game = session[:game]
	@game.player1.place(session[:ship], params[:coordinate], session[:orientation])	
	@game.player1_home_grid.update_for(@game.player1)
	session[:ship] = nil
	session[:orientation] = nil
	redirect '/game'
end