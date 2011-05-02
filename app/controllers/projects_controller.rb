class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :init_projects
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :mobile

  def index # see init_projects
  end

  def show # see init_projects
  end

  def new # see init_projects
  end

  def edit # see init_projects
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, :notice => t('successes.created', :model=> Project.model_name.human)
    else
      render "index"
    end
  end

  def update
    begin
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :alert => t('errors.not_found', :model=> Project.model_name.human)
    end
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => t('successes.updated', :model=> Project.model_name.human)
    else
      render "index"
    end
  end
  
  def destroy
    flash[:notice] = t('successes.destroyed', :model=> Project.model_name.human) if Project.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = t('errors.destroyed', :model=> Project.model_name.human)
    ensure
      redirect_to projects_path
  end
  
  def report
    @project.set_sums
    @currency = Configuration.find_by_key('currency').value
    render :layout => false, :template => 'projects/report'
  end
  
  def switch
    @project.closed = @project.closed == 0 ? 1 :0
    if @project.save
      flash[:notice] = t('successes.changed', :model=> Project.model_name.human)
    else
      flash[:notice] = t('errors.changed', :model=> Project.model_name.human)
    end
    redirect_to(@project)
  end
  
  def subscribe_user
    if request.post?
      projectsUsers = ProjectsUsers.new(params[:projects_users])
      if projectsUsers.save
        flash[:notice] = t('successes.created', :model=> ProjectsUsers.model_name.human)
      else
        flash[:notice] = t('errors.created', :model=> ProjectsUsers.model_name.human)
      end
      redirect_to(@project)
    else
      @displaySubscriberForm =  true
      @users_subscribeable = User.all - @project.users
      render "index"
    end
  end
  
  def unsubscribe_user
    user = User.find(params[:user_id])
    if @project.users.delete(user)
      flash[:notice] = t('successes.destroyed', :model=> ProjectsUsers.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model=> ProjectsUsers.model_name.human)
    end
    redirect_to(@project)
  end
  
  protected
  def init_projects
    @projects, @project, @project_tab = Project.get_view_objects(params, current_user)
    @customers, @customer, @contacts, @contact, @show_project_form = Project.get_form_objects(params)
  end

  def render_filter
    respond_with(@project) do |format|
      format.html { render "index" }
    end
  end
end
