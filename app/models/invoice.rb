class Invoice < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  validates_presence_of :user
  validates :title, :length => {:minimum => 3, :maximum => 254}
  validates :started_at, :datetime => true
  validates :ended_at, :datetime => true
  validates_with InvoiceValidator
end
