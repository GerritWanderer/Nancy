class Location < ActiveRecord::Base
  belongs_to :customer
  has_many :contacts, :dependent => :delete_all
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  
  validates :name, :length => {:minimum => 3, :maximum => 254}
  validates :street, :length => {:minimum => 3, :maximum => 254}
  validates :zip, :length => {:minimum => 3, :maximum => 10}
  validates :city, :length => {:minimum => 3, :maximum => 254}
  
  cattr_reader :per_page
  @@per_page = 1
end