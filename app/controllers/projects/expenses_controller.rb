class Projects::ExpensesController < ApplicationController
  before_filter :authenticate_user!, :init_expenses
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :mobile
  
  def index # see init_expenses
  end
  
  def show # see init_expenses
  end

  def new # see init_expenses
  end

  def edit # see init_expenses
  end

  def create
    params[:expense][:user_id] = current_user.id
    @expense = @project.expenses.build(params[:expense])
    if @expense.save
      redirect_to @project, :notice  => t('successes.created', :model=> Expense.model_name.human)
    else
      render 'projects/index'
    end
  end
  
  def update
    if @expense.update_attributes(params[:expense])
      redirect_to @project, :notice  => t('successes.updated', :model=> Expense.model_name.human)
    else
      render 'projects/index'
    end
  end
  
  def destroy
    if @project.expenses.delete(@expense)
      flash[:notice] = t('successes.destroyed', :model => Expense.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model => Expense.model_name.human)
    end
    redirect_to @project
  end
  
  def init_expenses
    @projects, @project, @customers, @customer, @contacts, @contact, @project_tab = Project.get_resources(params, current_user)
    @show_project_form, @show_expense_form, @show_invoice_form, show_status_message_form = Project.get_visibility_options(params[:controller], params[:action])
    @expense = params[:id] ? @project.expenses.find(params[:id]) : Expense.new
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :alert => t('errors.not_found', :model=> Project.model_name.human)
  end
  def render_filter
    render 'projects/index'
  end
end