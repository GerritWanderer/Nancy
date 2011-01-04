class Customer < ActiveRecord::Base
  has_many :locations
  accepts_nested_attributes_for :locations, :allow_destroy => true
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :shortname, :message => "can't be blank"
end