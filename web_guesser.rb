require 'sinatra'
require 'sinatra/reloader'

secret = rand(101)

get "/" do
	erb :index, locals: {number: secret}
end