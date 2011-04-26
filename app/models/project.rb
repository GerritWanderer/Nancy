class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact
  has_many :works, :dependent => :delete_all
  has_and_belongs_to_many :users
  
  validates :title, :presence => true, :length => {:minimum => 3, :maximum => 254}
  validates_presence_of :description, :message => "Description can't be blank"
  
  scope :by_customer_isClosed, proc {|customer, status| where(:customer_id => customer, :closed => status).order('title ASC') }
  scope :isClosed, lambda {|status| {:conditions => {:closed => status}}}
end