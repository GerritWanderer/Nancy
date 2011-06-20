class Work < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :text_template
  before_validation :set_datetimes
  
  attr_accessor :day
  
  include ActiveModel::Validations
  validates_presence_of :project
  validates :started_at, :datetime => true
  validates :ended_at, :datetime => true
  validates :fee, :numericality => true
  validates :description, :length => {:minimum => 3, :maximum => 999}
  validates_with WorkValidator
  
  default_scope :order => "started_at ASC"
  scope :from_day_by_user, lambda { |day, user| where(:user_id => user).where("started_at BETWEEN ? AND ?", day+" 00:00", day+" 23:59") }
  scope :in_range, lambda { |started_at, ended_at| where("started_at BETWEEN ? AND ?", started_at+" 00:00", ended_at+" 23:59") }
  
  def self.get_basic_view_variables
    fees = Configuration.find_by_key('work_fees') ? Configuration.find_by_key('work_fees').value.split(';') : [0.00]
    currency = Configuration.find_by_key('currency') ? Configuration.find_by_key('currency').value : '$'
    work_titles = TextTemplate.find_all_by_kind('work_title')
    work_descriptions = TextTemplate.find_all_by_kind('work_description')
    return currency, fees, work_titles, work_descriptions
  end
  
  def self.get_selected_day(params)
    if params[:date]
      day_selected = Date.parse(params[:date])
    elsif params[:work]
      day_selected = Date.parse(params[:work][:day])
    else
      day_selected = Date.today
    end
    beginning_of_week = day_selected.-(day_selected.cwday - 1)
    return day_selected, beginning_of_week
  end
  
  def self.get_customer_and_project_records(params)
    customers = Customer.with_active_projects.joins(:projects).uniq
    if customers.empty?
      projects = []
      project_form_id = nil
    else
      projects = params[:customer_id] ? Project.by_customer_isClosed(params[:customer_id], 0) : Project.by_customer_isClosed(customers.first.id, 0)
      project_form_id = !params[:project_id].nil? && Project.exists?(params[:project_id]) ? params[:project_id] : projects.first.id
    end
    return customers, projects, project_form_id
  end
  
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
    self.started_at = "#{self.day} #{self.started_at}"
    self.ended_at = "#{self.day} #{self.ended_at}"
  end
end