require 'haml'
require 'json'
require 'logger'
require 'rubygems'
require 'sinatra'

load 'magic.rb'


enable :sessions
set :haml, :format => :html5

logger = Logger.new(STDOUT)
logger.level = Logger::INFO


get '/' do
  if params.count == 0
    session[:request_token] = Magic.to_twitter
    redirect session[:request_token].authorize_url
  end

  response = Magic.from_twitter(session[:request_token], params['oauth_token'], params['oauth_verifier'])
  logger.info(response)
  haml :index
end


get '/magic' do
  username = params['username']
  json = { username: username }.to_json

  content_type :json
  json
end
