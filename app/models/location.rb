class Location < ActiveRecord::Base
  belongs_to :customer
  has_many :contacts
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :street, :message => "can't be blank"
  validates_presence_of :zip, :message => "can't be blank"
  validates_presence_of :city, :message => "can't be blank"
  validates_presence_of :customer_id, :message => "can't be blank"
end