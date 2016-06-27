require 'sinatra'
require 'sinatra/reloader'

set secret: (rand(100) + 1)

def generate_message guess
	message = ((guess - settings.secret).abs > 5) ? "way " : ""
	message += "Too high!" if guess > settings.secret
	message += "Too low!" if guess < settings.secret
	message = "You got it!" if guess == settings.secret
	message
end

get "/" do
	guess = params["guess"].to_i
	message = generate_message(guess).capitalize
	erb :index, locals: {number: settings.secret, message: message}
end
