class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :init_projects
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :mobile

  def index #empty method? I should be doing a something more then in init_projects
  end

  def show #empty method? I should be doing a something more then in init_projects
  end

  def new #empty method? I should be doing a something more then in init_projects
  end

  def edit #empty method? I should be doing a something more then in init_projects
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = t('successes.created', :model=> Project.model_name.human)
      respond_with(@project)
    else
      render "index"
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = t('successes.updated', :model=> Project.model_name.human)
      respond_with(@project)
    else
      @form_project = @project
      render "index"
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = t('successes.destroyed', :model=> Project.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model=> Project.model_name.human)
    end
    redirect_to(projects_url)
  end
  
  def report
    render :layout => false, :template => 'projects/report'
  end
  
  def switch
    @project = Project.find(params[:id])
    @project.closed = @project.closed == 0 ? 1 :0
    if @project.save
      flash[:notice] = t('successes.changed', :model=> Project.model_name.human)
    else
      flash[:notice] = t('errors.changed', :model=> Project.model_name.human)
    end
    redirect_to(@project)
  end
  
  protected
  def init_projects
    @projects = params[:closed] ? Project.isClosed(params[:closed]).joins(:customer).order(params[:order]) : Project.joins(:customer).order(params[:order])
    @project = params[:id] ? Project.find(params[:id]) : Project.new
    
    @form_project = params[:action] == 'edit' ? @project : Project.new
    @form_customers = Customer.all
    if !@form_customers.empty?
      @form_contacts = params[:customer_id] ? Contact.find_by_customer_id(params[:customer_id]) : Contact.find_by_customer_id(@form_customers.first.id)
    else
      flash.now[:notice]  = "No customers available - without a customer, this section is not view'able. Go ahead and create a Customer"
      render :layout => 'errors', :template => "errors/show"
    end
    
    @displayProjectForm = params[:action] == 'new' || params[:action] == 'edit' || params[:action] == 'create' || params[:action] == 'update' ? 'block' : 'none'
  end
  
  def render_filter
    respond_with(@project) do |format|
      format.html { render "index" }
    end
  end
end
