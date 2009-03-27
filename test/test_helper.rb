require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_record'

begin; require 'redgreen'; rescue; end

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit' 
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb')) 

def load_schema
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
  
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))  
  db_adapter = ENV['DB'] 
  ActiveRecord::Base.establish_connection(config[db_adapter]) 
  
  load(File.dirname(__FILE__) + "/schema.rb") 
  require File.dirname(__FILE__) + '/../rails/init.rb' 
end