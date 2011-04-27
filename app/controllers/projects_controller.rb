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
    @currency = Configuration.find_by_key('currency').value
    @tax = Configuration.find_by_key('tax').value.to_f
    @net_sum = 0
    @project.works.each do |work|
      @net_sum += (work.duration.to_f / 60) * work.fee
    end
    @discount = @net_sum * (@project.discount / 100)
    @full_net_sum = @net_sum - @discount
    @tax_sum = @full_net_sum * (@tax / 100)
    @full_tax_sum = @full_net_sum + @tax_sum
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
    # Find Project / Create new behavior for project form
    @project = params[:id] ? Project.find(params[:id]) : Project.new
    if params[:closed].to_i == 1 || @project.closed == 1
      @projects = Project.isClosed(1).joins(:customer).order(params[:order])
      @project_tab = 'closed'
    else
      if @project.users.exists?(current_user.id) || (params[:id].nil? && params[:closed].nil?)
        @projects = Project.isClosed(0).joins(:customer, :users).where("users.id" => current_user.id).order(params[:order])
        @project_tab = 'subscribed'
      else
        @projects = Project.isClosed(0).joins(:customer).order(params[:order])
        @project_tab = 'active'
      end
    end
    
    @form_project = params[:action] == 'edit' ? @project : Project.new
    @form_customers = Customer.all
    if @form_customers.empty?
      @form_customer_id, @form_contact_id = nil
      @form_contacts = []
    else
      @form_customer_id = @form_customers.first.id
      @form_contacts = params[:customer_id] ? Contact.find_by_customer_id(params[:customer_id]) : Contact.find_by_customer_id(@form_customer_id)
      @form_contact_id = @form_contacts.first.id
    end
    @form_display_mode = 'block' if ['new', 'edit', 'create'].index(params[:action]) 
  end
  
  def render_filter
    respond_with(@project) do |format|
      format.html { render "index" }
    end
  end
end
