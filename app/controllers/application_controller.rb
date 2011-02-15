class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  before_filter :check_for_first_customer, :except => [:new_first_customer, :create_first_customer] 
  layout :layout_by_resource
  include ApplicationHelper
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  
  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  def check_for_first_customer
    # check if no customer exist, but still allow "logout"
    if user_signed_in? && Customer.count == 0 && params[:controller]+"/"+params[:action] != "devise/sessions/destroy"
      redirect_to first_customers_url # display first customer wizard
    end
  end
  
  def layout_by_resource
    if devise_controller?
      "users"
    else
      "application"
    end
  end
end