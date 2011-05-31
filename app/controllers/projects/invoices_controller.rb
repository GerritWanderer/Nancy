class Projects::InvoicesController < ApplicationController
  before_filter :init_invoices
  before_filter :render_filter, :only => ['index', 'show', 'edit']
  
  def index # see init_invoices
  end
  
  def show # see init_invoices
  end
  
  def new
    @invoice.started_at, @invoice.ended_at = @project.get_invoice_dates
    render 'projects/index'
  end
  
  def edit # see init_invoices
  end
  
  def create
    params[:invoice][:user_id] = current_user.id
    @invoice = @project.invoices.build(params[:invoice])
    if @invoice.save
      flash.now[:notice] = t('successes.created', :model=> Invoice.model_name.human)
      @show_invoice_form = false
    end
    render 'projects/index'
  end
  
  def update
    begin
      @invoice = @project.invoices.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :alert => t('errors.not_found', :model=> Invoice.model_name.human)
    end
    if @invoice.update_attributes(params[:invoice])
      redirect_to @project, :notice  => t('successes.updated', :model=> Invoice.model_name.human)
    else
      render 'projects/index'
    end
  end
  
  def destroy
    flash[:notice] = t('successes.destroyed', :model=> Invoice.model_name.human) if @project.invoices.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = t('errors.destroyed', :model=> Invoice.model_name.human)
    ensure
      redirect_to @project
  end
  
  def switch
    @invoice.closed = @invoice.closed == 0 ? 1 : 0
    if @invoice.save
      flash[:notice] = t('successes.changed', :model=> Invoice.model_name.human)
    else
      flash[:notice] = t('errors.changed', :model=> Invoice.model_name.human)
    end
    redirect_to(@project)
  end
  
  def init_invoices
    @projects, @project, @customers, @customer, @contacts, @contact, @project_tab = Project.get_resources(params, current_user)
    @show_project_form, @show_expense_form, @show_invoice_form, show_status_message_form = Project.get_visibility_options(params[:controller], params[:action])
    @invoice = params[:id] ? Invoice.find(params[:id]) : Invoice.new
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :alert => t('errors.not_found', :model=> Project.model_name.human)
  end
  def render_filter
    render 'projects/index'
  end
end
