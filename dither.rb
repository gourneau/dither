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
  magic = Magic.magic(timeline)

  content_type :json
  magic.to_s

  # haml :index
end
