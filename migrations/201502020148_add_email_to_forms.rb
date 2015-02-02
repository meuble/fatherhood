require 'rubygems'
require 'yaml'
require "active_record"

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '..', 'config', 'config.yml'))

ActiveRecord::Base.establish_connection(config["database"])

ActiveRecord::Schema.define(:version => 201502020148) do
  add_column :forms, :email, :string
end
