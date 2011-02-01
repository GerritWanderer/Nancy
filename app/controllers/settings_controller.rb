class SettingsController < ApplicationController
	before_filter :authenticate_user!
	
  def index
		redirect_to user_settings_path
  end

	def user
		@users = User.all
		@user = User.new
	end
	
	def holiday
		@day_sequence = DaySequence.new
		@holidays_current_year = DaySequence.find_holidays_by_year(Date.today.year)
		@holiday_upcoming = DaySequence.find_upcoming_holiday("2011-02-11")
	end
end