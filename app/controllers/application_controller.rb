class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
	before_filter :check_for_first_customer, :except => [:first] 
  layout :layout_by_resource
  
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
    if user_signed_in? && Customer.count == 0 && params[:controller]+"/"+params[:action] != "devise/sessions/destroy" && params[:controller]+"/"+params[:action] != "customers/create"
        redirect_to :controller => 'customers', :action => 'first'
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