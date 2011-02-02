class Settings::DaySequencesController < ApplicationController
	def index
		@day_sequence = DaySequence.new
		@holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
		@holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
		render :layout => 'settings'
	end
	
	def show
		if params[:user_id]
			@user = User.find(params[:user_id])
			@vacation = DaySequence.find_type_by_user_and_year(2, @user.id, Date.today.year)
			@absences = DaySequence.find_type_by_user_and_year(3, @user.id, Date.today.year)
		else
			@holidays = DaySequence.find_holidays_by_year(Date.today.year)
		end
		
		@day_sequence = DaySequence.new
		@holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
		@holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
		render :layout => 'settings', :template => 'settings/day_sequences/index'
	end
	
  def create
		@day_sequence = DaySequence.new(params[:day_sequence])
		if @day_sequence.save
			redirect_to settings_day_sequence_path({:id => @day_sequence.date_from.year, :user_id => @day_sequence.user_id})
		else
			@holidays_current_year = DaySequence.count_holidays_by_year(Date.today.year)
			@holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
			render :layout => 'settings', :template => 'settings/day_sequences/index'
		end
  end

  def destroy
		@day_sequence = DaySequence.find(params[:id])
		redirect_params = @day_sequence.type_of_sequence == 1 ? {:id => @day_sequence.date_from.year} : {:id => @day_sequence.date_from.year, :user_id => @day_sequence.user_id}
		if @day_sequence.destroy
			redirect_to settings_day_sequence_path(redirect_params)
		else
			flash[:alert] = "An error occured while deleting the record"
		end
  end
end
