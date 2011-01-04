class Customer < ActiveRecord::Base
  has_many :locations
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :shortname, :message => "can't be blank"
end