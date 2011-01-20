class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact
  has_many :works

  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :description, :message => "can't be blank"
  
  scope :by_customer_isClosed, proc {|customer, status| where(:customer_id => customer, :closed => status) }
  scope :isClosed, lambda {|status| {:conditions => {:closed => status}}}
end
