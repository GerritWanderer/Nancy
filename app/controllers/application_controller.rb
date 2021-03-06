class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  before_filter :set_locale
  before_filter :set_admin_flag
  layout :layout_by_resource
  include ApplicationHelper
  
  # Rootingfehler beheben bei DELETE-AJAX Request im Workcontroller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def set_locale
    I18n.locale = params[:locale]
  end
  def set_admin_flag
    session[:admin] = true if current_user && current_user.role == "admin" && session[:admin].nil?
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
    devise_controller? ? "users" : "application"
  end
end