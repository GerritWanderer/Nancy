class Settings::DaySequencesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @day_sequence = DaySequence.new
    @holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
    @holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
  end
  
  def show_holidays
    @holidays = DaySequence.find_holidays_by_year(Date.today.year)
    
    @day_sequence = DaySequence.new
    @holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
    @holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
    render :template => 'settings/day_sequences/index'
  end
  
  def show_user
    @user = User.find(params[:user_id])
    @vacation = DaySequence.find_type_by_user_and_year(2, @user.id, Date.today.year)
    @absences = DaySequence.find_type_by_user_and_year(3, @user.id, Date.today.year)
    
    @day_sequence = DaySequence.new
    @holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
    @holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
    render :template => 'settings/day_sequences/index'
  end
  
  def create
    @day_sequence = DaySequence.new(params[:day_sequence])
    if @day_sequence.save
      redirect_to @day_sequence.type_of_sequence == 1 ? show_holidays_settings_day_sequences_path : show_user_settings_day_sequences_path(:user_id => @day_sequence.user_id)
    else
      @holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
      @holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
      render :template => 'settings/day_sequences/index', :notice => "Sequence was successfully saved"
    end
  end

  def destroy
    @day_sequence = DaySequence.find(params[:id])
    if @day_sequence.destroy
      redirect_to @day_sequence.type_of_sequence == 1 ? show_holidays_settings_day_sequences_path : show_user_settings_day_sequences_path(:user_id => @day_sequence.user_id)
    else
      render :template => 'settings/day_sequences/index', :alert => "An error occured while deleting the record"
    end
  end
end
