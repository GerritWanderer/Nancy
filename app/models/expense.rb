class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :user
  validates :description, :length => {:minimum => 3, :maximum => 999}
  validates :amount, :numericality => true
end
