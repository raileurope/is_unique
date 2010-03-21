require 'active_record'
require File.expand_path(File.dirname(__FILE__) + "/../lib/is_unique")
require 'spec'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

class Location < ActiveRecord::Base
  is_unique
end
