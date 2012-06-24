require 'haml'
require 'json'
require 'logger'
require 'rubygems'
require 'sinatra'

load 'magic.rb'


set :haml, :format => :html5
logger = Logger.new(STDOUT)
logger.level = Logger::INFO


get '/' do
  # haml :index
  logger.info(params)
  redirect Magic.get_oauth_url
end


get '/magic' do
  username = params['username']
  json = { username: username }.to_json

  content_type :json
  json
end
