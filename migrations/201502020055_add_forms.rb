require 'rubygems'
require 'yaml'
require "active_record"

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'config.yml'))

ActiveRecord::Base.establish_connection(config["database"])

ActiveRecord::Schema.define(:version => 201502020055) do

  create_table "forms", :force => true do |t|
    t.binary "data", :limit => 100000
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
