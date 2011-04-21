class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  before_filter :set_locale
  layout :layout_by_resource
  include ApplicationHelper
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def set_locale
    I18n.locale = params[:locale]
  end  
  def default_url_options(options={})
    { :locale => I18n.locale }
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
  
  def layout_by_resource
    if devise_controller?
      "users"
    else
      "application"
    end
  end
end