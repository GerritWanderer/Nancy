class SettingsController < ApplicationController
	before_filter :authenticate_user!
	
  def index
		@users = User.all
		@user = User.new
  end
end
