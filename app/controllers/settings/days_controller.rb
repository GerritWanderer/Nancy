class Settings::DaysController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @day = Day.new
    @holidays_current_year = Day.count_holidays_by_year(Date.today.year)
    @holiday_upcoming = Day.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
  end
  
  def show_holidays
    @holidays = Day.find_holidays_by_year(Date.today.year)
    
    @day = Day.new
    @holidays_current_year = Day.count_holidays_by_year(Date.today.year)
    @holiday_upcoming = Day.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
    render :template => 'settings/days/index'
  end
  
  def show_user
    @user = User.find(params[:user_id])
    @vacation = Day.find_type_by_user_and_year(2, @user.id, Date.today.year)
    @absences = Day.find_type_by_user_and_year(3, @user.id, Date.today.year)
    
    @day = Day.new
    @holidays_current_year = Day.count_holidays_by_year(Date.today.year)
    @holiday_upcoming = Day.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
    render :template => 'settings/days/index'
  end
  
  def create
    @day = Day.new(params[:day])
    if @day.save
      redirect_to @day.type_of_day == 1 ? show_holidays_settings_days_path : show_user_settings_days_path(:user_id => @day.user_id)
    else
      @holidays_current_year = Day.count_holidays_by_year(Date.today.year)
      @holiday_upcoming = Day.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
      render :template => 'settings/days/index', :notice => " was successfully saved"
    end
  end

  def destroy
    @day = Day.find(params[:id])
    if @day.destroy
      redirect_to @day.type_of_day == 1 ? show_holidays_settings_days_path : show_user_settings_days_path(:user_id => @day.user_id)
    else
      render :template => 'settings/days/index', :alert => "An error occured while deleting the record"
    end
  end
end
