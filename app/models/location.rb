class Location < ActiveRecord::Base
  belongs_to :customer
  has_many :contacts, :dependent => :delete_all
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  
  validates :name, :presence => true, :length => {:minimum => 3, :maximum => 254}
  validates :street, :presence => true, :length => {:minimum => 3, :maximum => 254}
  validates :zip, :presence => true, :length => {:minimum => 3, :maximum => 10}
  validates :city, :presence => true, :length => {:minimum => 3, :maximum => 254}
  
  cattr_reader :per_page
  @@per_page = 1
end