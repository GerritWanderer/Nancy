class Settings::DaySequencesController < ApplicationController
	def index
		@day_sequence = DaySequence.new
		@holidays_current_year = DaySequence.find_holidays_by_year(Date.today.year)
		@holiday_upcoming = DaySequence.find_upcoming_holiday(Date.today.strftime("%Y-%m-%d"))
		render :layout => 'settings'
	end
  def create
		@day_sequence = DaySequence.create(params[:day_sequence])
		if @day_sequence.save
			redirect_to holiday_settings_path
		else
			render :layout => 'settings', :template => 'settings/holiday'
		end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
