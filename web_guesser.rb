require 'sinatra'
require 'sinatra/reloader'

secret = rand(101)

get "/" do
	"the secret number is: #{secret}"
end