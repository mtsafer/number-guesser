require 'sinatra'
require 'sinatra/reloader'

@@guesses_left = 5
set secret: (rand(100) + 1)

def generate_secret
	settings.secret = rand(100) + 1
end

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
	@@guesses_left -= 1
	if @@guesses_left <= 0
		message = "You have lost, a new number has been generated!"
		@@guesses_left = 5
		generate_secret unless guess == settings.secret
	end
	if guess == settings.secret
		message = "You got it!"
		@@guesses_left = 5
		generate_secret
	end
	erb :index, locals: {number: settings.secret, message: message,
											guesses: @@guesses_left}
end
