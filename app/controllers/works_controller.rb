class WorksController < ApplicationController
  before_filter :authenticate_user!, :init_works
  load_and_authorize_resource
	respond_to :html, :js
	
  def index
    @customers = Customer.with_active_projects.joins(:projects).uniq
    @projects = params[:customer_id] ? Project.by_customer_isClosed(params[:customer_id], 0) : Project.by_customer_isClosed(@customers.first.id, 0)
		render 'index.js' if request.xhr?
  end
	
	def switch_customer
		@projects = Project.by_customer_isClosed(params[:customer_id], 0)
	end
	
  def create
    params[:work][:user_id] = current_user.id
    params[:work][:start_datetime] = params[:work][:day]+" "+params[:work][:started_at]
    params[:work][:end_datetime] = params[:work][:day]+" "+params[:work][:ended_at]
    @work = Work.new(params[:work])
    if @work.save
      redirect_to works_path(:date => params[:work][:day]), :notice => t('successes.created', :model=> Work.model_name.human) unless request.xhr?
    else
      params[:project_id] = params[:work][:project_id]
      params[:customer_id] = Project.find(params[:work][:project_id]).customer.id
      @customers = Customer.with_active_projects.joins(:projects).uniq
      @projects = Project.by_customer_isClosed(params[:customer_id], 0)
      render request.xhr? ? 'create.js' : 'index'
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
    
    @works = Work.from_day_by_user(@daySelected.strftime("%Y-%m-%d"), current_user.id).order("started_at ASC")
    @work = Work.new
    @statistics = Work.calculateStatistics(@works, current_user.hours)
  end
end