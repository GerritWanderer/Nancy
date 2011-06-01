class Projects::InvoicesController < ApplicationController
  before_filter :authenticate_user!, :init_invoices
  before_filter :render_filter, :only => [:index, :show, :edit]
  respond_to :html, :mobile
  
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
      redirect_to @project, :notice  => t('successes.created', :model=> Invoice.model_name.human)
    else
      render 'projects/index'
    end
  end
  
  def update
    if @invoice.update_attributes(params[:invoice])
      redirect_to @project, :notice  => t('successes.updated', :model=> Invoice.model_name.human)
    else
      render 'projects/index'
    end
  end
  
  def destroy
    if @project.invoices.delete(@invoice)
      flash[:notice] = t('successes.destroyed', :model=> Invoice.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model=> Invoice.model_name.human)
    end
    redirect_to @project
  end
  
  def switch
    @invoice.closed = @invoice.closed == 0 ? 1 : 0
    if @invoice.save
      flash[:notice] = t('successes.changed', :model=> Invoice.model_name.human)
    else
      flash[:alert] = t('errors.changed', :model=> Invoice.model_name.human)
    end
    redirect_to @project
  end
  
  def init_invoices
    @projects, @project, @customers, @customer, @contacts, @contact, @project_tab = Project.get_resources(params, current_user)
    @show_project_form, @show_expense_form, @show_invoice_form, show_status_message_form = Project.get_visibility_options(params[:controller], params[:action])
    @invoice = params[:id] ? @project.invoices.find(params[:id]) : Invoice.new
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :alert => t('errors.not_found', :model=> Project.model_name.human)
  end
  def render_filter
    render 'projects/index'
  end
end
