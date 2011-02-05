class HomeController < ApplicationController
  def index
    flash.each do |key, value|
      flash[key] = value
    end
    redirect_to user_signed_in? == true ? works_path : new_user_session_path
  end
end