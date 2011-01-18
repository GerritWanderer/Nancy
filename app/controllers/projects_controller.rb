class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :init_projects
  respond_to :html, :js

  def index
    #see before_filter function init_customers
    respond_with(@projects)
  end

  def show
    @project = Project.find(params[:id])
    respond_with(@project) do |format|
      format.html { render "index" }
    end
  end
  
  def report
    @project = Project.find(params[:id])
    render :layout => false, :template => 'projects/report'
  end

  def new  
    respond_with(@project) do |format|
      format.html { render "index" }
    end
  end

  def edit
    respond_with(@project) do |format|
      format.html { render "index" }
    end
  end

  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def switch
    @project = Project.find(params[:id])
    @project.closed == 0 ? @project.closed = 1 : @project.closed = 0
    if @project.save
      redirect_to(@project, :notice => 'Project status was successfully switched.')
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
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
      flash[:notice]  = "To create a project, you'll need at first to create customers"
      render :layout => 'errors', :template => "errors/show"
    end
    
    @displayProjectForm = params[:action] == 'edit' || params[:action] == 'new' ? 'block' : 'none'
  end
end