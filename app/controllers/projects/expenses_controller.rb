class Projects::ExpensesController < ApplicationController
  def index # see init_expenses
  end
  
  def show # see init_expenses
  end

  def new # see init_expenses
    @project = Project.find(params[:project_id])
    if @project.users.exists?(current_user.id)
      @projects = Project.isClosed(0).joins(:customer, :users).where("users.id" => current_user.id).order(params[:order])
      @project_tab = 'subscribed'
    else
      @projects = Project.isClosed(0).joins(:customer).order(params[:order])
      @project_tab = 'active'
    end
    
    @form_project = Project.new
    @form_customers = Customer.all
    if @form_customers.empty?
      @form_customer_id, @form_contact_id = nil
      @form_contacts = []
    else
      @form_customer_id = @form_customers.first.id
      @form_contacts = params[:customer_id] ? Contact.find_by_customer_id(params[:customer_id]) : Contact.find_by_customer_id(@form_customer_id)
      @form_contact_id = @form_contacts.first.id
    end
      
    render 'projects/index'
  end

  def edit # see init_expenses
  end

  def create
    @expense = Expense.new(params[:expense])
    if @expense.save
      flash[:notice] = t('successes.created', :model=> Expense.model_name.human)
    else
      flash[:notice] = t('errors.created', :model=> Expense.model_name.human)
    end
    redirect_to project_path(@expense.project)
  end

  def destroy
    @expense = Expense.find(params[:id])
    if @expense.destroy
      redirect_to project_path(@expense.project)
    end
  end

end
