class Day < ActiveRecord::Base
  belongs_to :user
  
  include ActiveModel::Validations
  validates :date_from, :presence => true, :date => true
  validates :date_to, :presence => true, :date => true
  validates_inclusion_of :type_of_day, :in => 1..3
  validates_with DayValidator, :if => Proc.new { |day| !day.date_from.nil? && !day.date_to.nil? }

  scope :by_type_within_date, lambda {|day_type, from, to| where(:type_of_day => day_type, :date_from => from, :date_to => to) }
  scope :find_upcoming_holiday, lambda {|date| where("date_from > ?", date).order('"date_from" ASC').limit(1) }
  scope :find_type_by_user_and_year, lambda {|day_type, user, year| where(:type_of_day => day_type, :user_id => user).where("date_from BETWEEN '?-01-01' AND '?-12-31'", year, year) }
  scope :find_holidays_by_year, lambda {|year| where(:type_of_day => 1).where("date_from BETWEEN '?-01-01' AND '?-12-31'", year, year).order('date_to ASC') }

  def self.count_holidays_by_year(year)
    holiday_records = Day.where(:type_of_day => 1).where("date_from BETWEEN '?-01-01' AND '?-12-31'", year, year)

    holidays = 0
    holiday_records.each do |holiday_record|
      holidays += (holiday_record.date_to.to_time.to_i - holiday_record.date_from.to_time.to_i) / 24 / 60 / 60 + 1
    end
    holidays
  end
end