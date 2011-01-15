class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact
  has_many :works
  
  scope :isClosed, lambda {|status| {:conditions => {:closed => status}}}
end
