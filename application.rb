require 'rubygems'
require 'sinatra'
require 'awesome_print'
require 'haml'

set :haml, :format => :html5

get '/' do
  haml :form
end
