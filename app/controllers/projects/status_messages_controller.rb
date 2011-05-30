class Projects::StatusMessagesController < ApplicationController
  before_filter :init_status_message
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  
  def index # see init_status_messages
  end
  
  def show # see init_status_messages
  end

  def new # see init_status_messages
  end

  def edit # see init_status_messages
  end

  def create
    params[:status_message][:user_id] = current_user.id
    @status_message = @project.status_messages.build(params[:status_message])
    if @status_message.save
      flash.now[:notice] = t('successes.created', :model=> StatusMessage.model_name.human)
      @show_status_message_form = false
    end
    render 'projects/index'
  end
  
  def update
    begin
      @status_message = @project.status_messages.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to @project, :alert => t('errors.not_found', :model=> StatusMessage.model_name.human)
    end
    if @status_message.update_attributes(params[:status_message])
      redirect_to @project, :notice => t('successes.updated', :model=> StatusMessage.model_name.human)
    else
      render 'projects/index'
    end
  end
  
  def destroy
    @status_message = StatusMessage.find(params[:id])
    if @status_message.destroy
      redirect_to project_path(@status_message.project)
    end
  end
  
  def init_status_message
    @projects, @project, @customers, @customer, @contacts, @contact, @project_tab = Project.get_resources(params, current_user)
    @show_project_form, @show_expense_form, @show_invoice_form, @show_status_message_form = Project.get_visibility_options(params[:controller], params[:action])
    @status_message = params[:id] ? StatusMessage.find(params[:id]) : StatusMessage.new
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :alert => t('errors.not_found', :model=> Project.model_name.human)
  end
  def render_filter
    render 'projects/index'
  end
end
