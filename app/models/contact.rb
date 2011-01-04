class Contact < ActiveRecord::Base
  belongs_to :location
  
  validates_presence_of :salutation, :message => "can't be blank"
  validates_presence_of :firstname, :message => "can't be blank"
  validates_presence_of :lastname, :message => "can't be blank"
  #validates_presence_of :location_id, :message => "can't be blank"
end