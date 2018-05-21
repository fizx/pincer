require "sinatra"

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ARGV[0] && ARGV[0].size > 0
end

def safe(hash)
  raise unless hash =~ /\A[a-zA-Z0-9]{40,60}\Z/
  hash
end

get '/' do
  `ipfs pin ls 2>&1`
end

get '/pin/?' do
  `ipfs pin ls 2>&1`
end

get '/pin/:hash' do
  `ipfs pin ls #{safe(params["hash"])} 2>&1`
end

post '/pin/:hash' do
  `ipfs pin add --progress false #{safe(params["hash"])} 2>&1`
end

delete '/pin/:hash' do
  `ipfs pin rm #{safe(params["hash"])} 2>&1`
end
