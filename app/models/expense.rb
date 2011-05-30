class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :user
  validates :description, :length => {:minimum => 3, :maximum => 999}
  validates :amount, :numericality => true

  scope :in_range, lambda { |started_at, ended_at| where("created_at BETWEEN ? AND ?", started_at+" 00:00", ended_at+" 23:59") }
end
