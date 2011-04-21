class WorksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :init_works, :except => [:destroy]
	respond_to :html, :js, :mobile
	
  def index
    init_customers_and_projects
    render 'index.js' if request.xhr? # rails does not render index.js.erb correct - must be set explicitly on this action
  end
	
	def switch_customer
		@projects = Project.by_customer_isClosed(params[:customer_id], 0)
		init_customers_and_projects
    render 'index' unless request.xhr?
	end

  def create
    params[:work][:start_datetime] = params[:work][:day]+" "+params[:work][:started_at]
    params[:work][:end_datetime] = params[:work][:day]+" "+params[:work][:ended_at]
    @work = Work.new(params[:work])
    if @work.save
      redirect_to works_path(:date => params[:work][:day]), :notice => t('successes.created', :model=> Work.model_name.human) unless request.xhr?
    else
      if Project.exists?(params[:work][:project_id])
        params[:project_id] = params[:work][:project_id]
        params[:customer_id] = Project.find(params[:work][:project_id]).customer.id
      else
        params[:project_id], params[:customer_id] = nil
      end
      init_customers_and_projects
      render 'index' unless request.xhr?
    end
  end

  def destroy
    work = Work.find(params[:id])
    date = work.started_at.strftime("%Y-%m-%d")
    if work.destroy
      redirect_to works_path(:date => date), :notice => t('successes.deleted', :model=> Work.model_name.human) unless request.xhr?
    end
  end
  
  protected
  def init_works
    if params[:date]
      @daySelected = Date.parse(params[:date])
    elsif params[:work]
      @daySelected = Date.parse(params[:work][:day])
    else
      @daySelected = Date.today
    end
    @dayCalendar = @daySelected.-(@daySelected.cwday - 1)
    @jumping_links = Work.selectJumpingLinks(@dayCalendar)
    
    @fees = Configuration.find_by_key('work_fees') ? Configuration.find_by_key('work_fees').value.split(';') : [0.00]
    @currency = Configuration.find_by_key('currency') ? Configuration.find_by_key('currency').value : '$'
    @works = Work.from_day_by_user(@daySelected.strftime("%Y-%m-%d"), current_user.id).order("started_at ASC")
    @work = Work.new
    @statistics = Work.calculateStatistics(@works, current_user.hours)
  end
  
  def init_customers_and_projects
    @customers = Customer.with_active_projects.joins(:projects).uniq
    if @customers.empty?
      @projects = []
      @project_form_id = nil
    else
      @projects = params[:customer_id] ? Project.by_customer_isClosed(params[:customer_id], 0) : Project.by_customer_isClosed(@customers.first.id, 0)
      @project_form_id = Project.exists?(params[:project_id]) ? params[:project_id] : @projects.first.id
    end
  end
end