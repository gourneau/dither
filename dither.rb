require 'haml'
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
  user_info = response.body
  haml :index, locals: { user_info: user_info }
end
