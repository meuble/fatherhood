require 'rubygems'
require 'yaml'
require "active_record"

database_config_file = File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'database.yml')
config_file = File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'config.yml')

config = File.exists?(config_file) ? YAML::load_file(config_file) : {}
database_config = File.exists?(database_config_file) ? YAML::load(ERB.new(File.read(database_config_file)).result)["production"] : config["database"]
ActiveRecord::Base.establish_connection(database_config)

ActiveRecord::Schema.define(:version => 201502020148) do
  add_column :forms, :email, :string
end
