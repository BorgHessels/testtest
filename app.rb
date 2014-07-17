require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:wyltdb.sqlite3"

require './models'

set :sessions, true
require 'bundler/setup'
require 'rack-flash'
use Rack::Flash, :sweep => true

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])

	end
end
get '/' do
	redirect '/sign-in'
end


get '/sign-in' do
	erb :sign_in
end

post '/sign-in-process' do
@user = User.find_by_username params[:username]
if @user && @user.password == params[:password]
	session[:user_id] = @user.id
	flash[:message] = "You have logged in successfully<br>"
	redirect '/home'
else
	flash[:message] = "You've failed to log in<br>"
end
end

get '/home' do
	erb :home
end

get '/' do
	erb :sign_up
end

configure(:development) {set :database, "sqlite3:wyltdb.sqlite3"}