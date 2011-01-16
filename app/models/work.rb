class Work < ActiveRecord::Base
  belongs_to :project
  #belongs_to :user

  attr_accessor :day, :starttime, :endtime
  validates :description, :presence => true, :length => {:minimum => 3, :maximum => 1020}
  #validates :start, :presence => true, :worktime_format => true
  #validates :end, :presence => true, :worktime_format => true  
  
  #scope :from_day_by_user, proc {|day, user| where("start LIKE ?", day) }
  scope :from_day, proc {|day| where("start LIKE ?", day) }

  def self.selectJumpingLinks(date)
    #Return Hash with Elements (4 Dates)
    {"prev10"=>date.-(77).strftime("%Y-%m-%d"),"prev"=>date.-(7).strftime("%Y-%m-%d"),"next"=>date.+(7).strftime("%Y-%m-%d"),"next10"=>date.+(77).strftime("%Y-%m-%d")}
  end
  def self.calculateStatistics(works, hours)
    #Return Hash with Elements (4 Dates)
    if works.empty?
      {"duration"=>0, "hours_left"=>0-hours, "from"=>"-", "to"=>"-"}
    else
      duration = works.sum("duration").to_f / 60
      {"duration"=>duration, "hours_left"=>duration - hours, "from"=>works.first.start.strftime("%H:%M"), "to"=>works.last.end.strftime("%H:%M")}
    end
  end
end
