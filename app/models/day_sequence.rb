class DaySequence < ActiveRecord::Base
  belongs_to :user
  
  include ActiveModel::Validations
  validates :date_from, :presence => true, :date => true
  validates :date_to, :presence => true, :date => true
  validates_inclusion_of :type_of_sequence, :in => 1..3
  validates_with DaySequenceValidator, :if => Proc.new { |day_sequence| !day_sequence.date_from.nil? && !day_sequence.date_to.nil? }

  scope :by_type_within_date, lambda {|sequence_type, from, to| where(:type_of_sequence => sequence_type, :date_from => from, :date_to => to) }
  scope :find_upcoming_holiday, lambda {|date| where("date_from > ?", date).order('date_from ASC').limit(1) }
  scope :find_type_by_user_and_year, lambda {|sequence_type, user, year| where(:type_of_sequence => sequence_type, :user_id => user).where("date_from LIKE '%#{year}%'").where("date_to LIKE '%#{year}%'") }
  scope :find_holidays_by_year, lambda {|year| where(:type_of_sequence => 1).where("date_from LIKE '%#{year}%'").where("date_to LIKE '%#{year}%'").order('date_from ASC') }

  def self.count_holidays_by_year(year)
    holiday_records = DaySequence.where(:type_of_sequence => 1).where("date_from LIKE '%#{year}%'").where("date_to LIKE '%#{year}%'")

    holidays = 0
    holiday_records.each do |holiday_record|
      holidays += (holiday_record.date_to.to_time.to_i - holiday_record.date_from.to_time.to_i) / 24 / 60 / 60 + 1
    end
    holidays
  end
end