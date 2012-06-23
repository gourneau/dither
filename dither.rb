require 'haml'
require 'json'
require 'rubygems'
require 'sinatra'

load 'magic.rb'


set :haml, :format => :html5


get '/' do
  haml :index
end


get '/magic' do
  username = params['username']
  json = { username: username }.to_json

  content_type :json
  json
end
