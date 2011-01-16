class Contact < ActiveRecord::Base
  belongs_to :location
  
  validates_presence_of :salutation, :message => "can't be blank"
  validates_presence_of :firstname, :message => "can't be blank"
  validates_presence_of :lastname, :message => "can't be blank"
  #validates_presence_of :location_id, :message => "can't be blank"
  
  def self.find_by_customer_id(customer)
    locations = Location.find_all_by_customer_id(customer)
    contacts = Array.new
    locations.each do |location|
      location.contacts.collect {|c| contacts.push(c) }
    end
    contacts
  end
end