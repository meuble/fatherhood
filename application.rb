require 'rubygems'
require 'sinatra'
require 'awesome_print'
require 'haml'
require 'yaml'
require "active_record"

enable :sessions
set :haml, :format => :html5

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'config.yml'))

ActiveRecord::Base.establish_connection(config["database"])

class Form < ActiveRecord::Base
  validates_presence_of :data
end

get '/' do
  haml :index
end

get '/reset_session' do
  session[:has_access] = nil
end

post '/gate' do
  if config["password"] == params[:password]
    session[:has_access] = true
    redirect '/form/new'
  else
    redirect '/'
  end
end

get '/form/new' do
  if session[:has_access]
    haml :form
  else
    redirect '/'
  end
end

post '/forms' do
  form = Form.new(:data => params)
  if form.save
    redirect "/form/#{form.id}"
  else
    redirect "/form/new"
  end
end
