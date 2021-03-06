class WorksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_works, :except => [:destroy]
  respond_to :html, :js, :mobile

  def index
    render 'index.js' if request.xhr? # rails does not render index.js.erb correct - must be set explicitly on this action
  end
  
  def show
    redirect_to date_works_path(:date => @work.started_at.strftime("%Y-%m-%d"))
  end

  def create
    @work = current_user.works.build(params[:work])
    if @work.save
      redirect_to works_path(:date => params[:work][:day]), :notice => t('successes.created', :model=> Work.model_name.human) unless request.xhr?
    else
      begin
        project = Project.find(params[:work][:project_id])
        params[:project_id] = project.id
        params[:customer_id] = project.customer.id
      rescue ActiveRecord::RecordNotFound
        params[:project_id], params[:customer_id] = nil
      ensure
        render 'index' unless request.xhr?
      end
    end
  end
  
  def edit
    render 'index' unless request.xhr?
  end
  
  def update
    if @work.update_attributes(params[:work])
      redirect_to date_works_path(:date => @work.started_at.strftime("%Y-%m-%d")), :notice => t('successes.updated', :model=> Work.model_name.human) unless request.xhr?
    else
      render "index"
    end
  end
  
  def destroy
    flash[:notice] = t('successes.deleted', :model=> Work.model_name.human) if current_user.works.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = t('errors.deleted', :model=> Work.model_name.human)
    ensure
      redirect_to works_path(:date => params[:date])
  end
  
  def switch_customer
    render 'index' unless request.xhr?
  end
  
  protected
  def init_works
    @daySelected, @dayCalendar = Work.get_selected_day(params)
    @jumping_links = Work.selectJumpingLinks(@dayCalendar)
    @works = Work.from_day_by_user(@daySelected.strftime("%Y-%m-%d"), current_user.id)
    
    @work = params[:id] ? current_user.works.find(params[:id]) : Work.new({:started_at => Time.now, :ended_at => Time.now})
    @currency, @fees, @work_titles, @work_descriptions = Work.get_basic_view_variables
    @customers, @projects, @project_form_id = Work.get_customer_and_project_records(params)
    @statistics = Work.calculateStatistics(@works, current_user.hours)
  end
end
