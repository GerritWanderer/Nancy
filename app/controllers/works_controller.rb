class WorksController < ApplicationController
  #before_filter :authenticate_user!

  # Use Session-Date when request is nonXHR and Param:date is not found
  # Create Selected Date with param or current Date
  # Create JumpingLinks for Calender-Navigation
  # Load Customers with active Projects
  # Use Session-Customer when request is nonXHR and Param:customer is not found
  # Select active Projects by given Customer
  # Select Work-Entries from User of the previous selected Dates
  # Create Statistics
  def index
    params[:date] = session[:date] if !request.xhr? and !params[:date] and session[:date]
    params[:date] ? @daySelected = Date.parse(params[:date]) : @daySelected = Date.today
    @dayCalendar = @daySelected.-(@daySelected.cwday - 1)
    @jumping_links = Work.selectJumpingLinks(@dayCalendar)

    @customers = Customer.with_active_projects.joins(:projects).uniq
    params[:customer_id] ? @projects = Project.by_customer_isClosed(params[:customer_id], 0) : @projects = Project.by_customer_isClosed(@customers.first.id, 0)

    @work = Work.new
    #@works = Work.from_day_by_user("%"+@daySelected.strftime("%Y-%m-%d")+"%", current_user.id)
    @works = Work.from_day("%"+@daySelected.strftime("%Y-%m-%d")+"%").order("start ASC")
    #@statistics = Work.calculateStatistics(@works, current_user.hours)

    session[:date] = params[:date] if params[:date] && !request.xhr?
  end

  # Set userid to the param-list for Work
  # Set Start and Endtime as Time-Object
  # Calcuate Duration
  # Save Work and redirect to if request is nonXHR
  # Else select Work-Entries from User of the previous selected Dates and Create Statistics
  def create
    #params[:work][:user_id] = current_user.id
    timeStart = Time.parse(params[:work][:day]+" "+params[:work][:starttime])
    timeEnd = Time.parse(params[:work][:day]+" "+params[:work][:endtime])
    params[:work][:duration] = (timeEnd - timeStart) / 60
    params[:work][:start] = timeStart.strftime("%Y-%m-%d %H:%M")
    params[:work][:end] = timeEnd.strftime("%Y-%m-%d %H:%M")
    @work = Work.new(params[:work])
    if @work.save
      redirect_to works_path(:date => params[:work][:day]), :notice => 'Time created.' unless request.xhr?
      #@works = Work.from_day_by_user("%"+params[:work][:day]+"%", current_user.id)
      @works = Work.from_day("%"+params[:work][:day]+"%")
      #@statistics = Work.calculateStatistics(@works, current_user.hours)
    end
  end

  def destroy
    work = Work.find(params[:id])
    #if work.user_id == current_user.id
      date = work.start.strftime("%Y-%m-%d")
      if work.destroy
        redirect_to works_path(:date => date), :notice => 'Time deleted.' unless request.xhr?
      end
    #end
  end
end