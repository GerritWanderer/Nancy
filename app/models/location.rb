class Location < ActiveRecord::Base
  belongs_to :customer
  has_many :contacts
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :street, :message => "can't be blank"
  validates_presence_of :zip, :message => "can't be blank"
  validates_presence_of :city, :message => "can't be blank"
  #validates_presence_of :customer_id, :message => "can't be blank"
  
  cattr_reader :per_page
  @@per_page = 1
end