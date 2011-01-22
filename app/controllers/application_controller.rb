class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_for_first_customer, :except => [:first] 
  layout :layout_by_resource
  
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