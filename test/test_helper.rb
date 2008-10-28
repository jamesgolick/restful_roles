require File.dirname(__FILE__) + '/../init.rb'
require 'rubygems'
require 'activerecord'
require 'expectations'

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

ActiveRecord::Schema.define(:version => 0) do
  create_table :post do |t|
  end
end

class Post < ActiveRecord::Base
  permits :create, :if => lambda { |person| person.let_me_create? }
end

