# require 'board'
# require 'rubygems'
# require 'rspec'
# require "rack/test"
# require 'test/unit'


# describe "the board" do 
# 	include Rack::Test::Methods

# 	def app ; Sinatra::Application ; end

# 	it "creates a new game when root directory is accessed" do 
# 		get '/'
# 		expect(last_response).to be_ok
# 		expect(@game).to be_a Game
# 	end

# end
