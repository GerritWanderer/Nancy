class Work < ActiveRecord::Base
  belongs_to :project
  before_save :set_datetimes
  
  attr_accessor :day, :start_datetime, :end_datetime
  include ActiveModel::Validations
  validates_presence_of :project
  validates :start_datetime, :datetime => true
  validates :end_datetime, :datetime => true
  validates :fee, :numericality => true
  validates :description, :length => {:minimum => 3, :maximum => 1020}
  validates_with WorkValidator
  
  scope :from_day_by_user, lambda { |day, user| where(:user_id => user).where("started_at BETWEEN ? AND ?", day+" 00:00", day+" 23:59") }

  def self.selectJumpingLinks(date)
    #Return Hash with Elements (4 Dates)
    {"prev10"=>date.-(77).strftime("%Y-%m-%d"),"prev"=>date.-(7).strftime("%Y-%m-%d"),"next"=>date.+(7).strftime("%Y-%m-%d"),"next10"=>date.+(77).strftime("%Y-%m-%d")}
  end
  
  def self.calculateStatistics(works, hours)
    if works.empty?
      {"duration"=>0, "hours_left"=>0-hours, "from"=>"-", "to"=>"-"}
    else
      duration = works.sum("duration").to_f / 60
      {"duration"=>duration, "hours_left"=>duration - hours, "from"=>works.first.started_at.strftime("%H:%M"), "to"=>works.last.ended_at.strftime("%H:%M")}
    end
  end
  
  private
  def set_datetimes
    self.started_at = self.start_datetime
    self.ended_at = self.end_datetime
    self.duration = (self.ended_at - self.started_at) / 60
  end
end