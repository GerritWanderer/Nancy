class ProjectsController < ApplicationController
  before_filter :init_projects
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

  def new
    @project = Project.find(params[:id])
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
    params[:order] ? @projects = Project.find(:all, :order => params[:order]) : @projects = Project.all
    
    if params[:id]
      @project = Project.find(params[:id])
    else
      @project = Project.new
    end
    
    if params[:action] == 'edit'
      @form_project = @project
    else
      @form_project = Project.new
    end
    
    params[:action] == 'edit' ? @displayProjectForm = 'block' : @displayProjectForm = 'none'
  end
end