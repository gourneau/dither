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

  timeline = Magic.from_twitter(session[:request_token], params['oauth_token'], params['oauth_verifier'])
  timeline = JSON.parse(timeline)
  @friend = Magic.neglected_friends(timeline).first

  haml :index
end

get '/friends.json' do
  content_type :json

  timeline = Magic.from_twitter(session[:request_token], params['oauth_token'], params['oauth_verifier'])
  timeline = JSON.parse(timeline)
  Magic.neglected_friends(timeline)
end
