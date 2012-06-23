require 'haml'
require 'rubygems'
require 'sinatra'

require 'twitter'


set :haml, :format => :html5


get '/' do
  haml :index
end
