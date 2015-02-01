require 'rubygems'
require 'sinatra'
require 'awesome_print'
require 'haml'
require 'yaml'

enable :sessions
set :haml, :format => :html5

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'config.yml'))

get '/' do
  haml :index
end

get '/reset_session' do
  session[:has_access] = nil
end

post '/gate' do
  if config["password"] == params[:password]
    session[:has_access] = true
    redirect '/form'
  else
    redirect '/'
  end
end

get '/form' do
  if session[:has_access]
    haml :form
  else
    redirect '/'
  end
end
