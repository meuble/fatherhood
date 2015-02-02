require 'rubygems'
require 'sinatra'
require 'awesome_print'
require 'haml'
require 'yaml'
require 'json'
require "active_record"

enable :sessions
set :haml, :format => :html5

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'config.yml'))

ActiveRecord::Base.establish_connection(config["database"])

class Form < ActiveRecord::Base
  validates_presence_of :data

  STAI_KEYS = [
    "good_mood", "nervous", "self_happy", "feeling_happy",
    "feeling_failure", "feeling_rested", "cold_blooded",
    "feeling_overwhelmed", "feeling_worried", "is_happy",
    "disturbing_ideas", "lacking_confidence", "feeling_secured",
    "decision_maker", "feeling_incompetent", "is_satisfied",
    "disturbed_by_ideas", "remember_deceptions", "is_stable",
    "is_tense"
  ]

  EDINBURG_KEYS = [
    "has_laught", "confident_about_futur", "self_denunciation",
    "wrongly_worried", "frightened", "mostly_overwhelmed",
    "feeling_sad", "has_cried", "hurt_himself"
  ]

  def parsed_data
    @parsed_data ||= JSON.parse(self.data)
  end

  def stai_result
    result(STAI_KEYS)
  end

  def edinburg_result
    result(EDINBURG_KEYS)
  end

  def result(keys)
    self.parsed_data.inject(0) do |acc, v|
      acc += v.last.to_i if keys.include?(v.first)
      acc
    end
  end

  def results
    {
      :stai => stai_result,
      :edinburg => edinburg_result
    }
  end
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
  form = Form.new(:data => params.to_json)
  if form.save
    redirect "/form/#{form.id}"
  else
    redirect "/form/new"
  end
end

get '/form/:id' do
  form = Form.find(params[:id])
  haml :result, :locals => {:form => form}
end

post '/form/:id' do
  form = Form.find(params[:id])
  if form.update_attributes(:email => params[:email])
    redirect '/thanks'
  else
    redirect "/form/#{form.id}"
  end
end

get '/thanks' do
  haml :thanks
end
