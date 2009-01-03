$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'active_record'
require 'action_controller'
require 'activesupport'
require 'expectations'
require File.dirname(__FILE__) + '/../init.rb'

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

ActiveRecord::Schema.define(:version => 0) do
  create_table :posts do |t|
  end
end

class Post < ActiveRecord::Base
  permits(:create) { |trustee| trustee.let_me_create? }
  permits(:update) { |trustee, post| post.likes?(trustee) }
end

class MockController
  include RestfulRoles::ActionController
end

