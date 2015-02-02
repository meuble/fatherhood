require 'rubygems'
require 'yaml'
require "active_record"

database_config_file = File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'database.yml')
config_file = File.join(File.dirname(File.expand_path(__FILE__)), 'config', 'config.yml')

config = File.exists?(config_file) ? YAML::load_file(config_file) : {}
database_config = File.exists?(database_config_file) ? YAML::load(ERB.new(File.read(database_config_file)).result)["production"] : config["database"]
ActiveRecord::Base.establish_connection(database_config)

ActiveRecord::Schema.define(:version => 201502020055) do

  create_table "forms", :force => true do |t|
    t.binary "data", :limit => 100000
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
