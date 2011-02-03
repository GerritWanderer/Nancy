class Settings::UserController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.all
    @user = User.new
    render :layout => 'settings'
  end
  
  def show
  end

  def new
  end
  
  def create
    @user = User.create(params[:user])
    if @user.save
      redirect_to settings_user_admin_index_path
    else
      @users = User.all
      render :layout => 'settings', :template => 'settings/user/index'
    end
  end

  def edit
    @users = User.all
    @user = User.find(params[:id])
    render :layout => 'settings', :template => 'settings/user/index'
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].empty?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to settings_user_admin_index_path
    else
      @users = User.all
      render :layout => 'settings', :template => 'settings/user/index'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User was successfully deleted.'
    else
      flash[:alert] = 'An error occured while deleting your selected User.'
    end
    redirect_to settings_user_admin_index_path
  end
end
