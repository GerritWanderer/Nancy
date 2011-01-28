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
	end
end
