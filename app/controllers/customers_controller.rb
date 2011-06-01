class CustomersController < ApplicationController
  before_filter :authenticate_user!, :init_customers
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :js, :mobile

  def index # see init_customers
  end

  def show # see init_customers
  end

  def new # see init_customers
  end

  def edit # see init_customers
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to @customer, :notice => t('successes.created', :model=> Customer.model_name.human)
    else
      render 'index'
    end
  end
  
  def update
    if @customer.update_attributes(params[:customer])
      redirect_to @customer, :notice => t('successes.updated', :model=> Customer.model_name.human)
    else
      render 'index'
    end
  end
  
  def destroy
    flash[:notice] = t('successes.destroyed', :model=> Customer.model_name.human) if @customer.destroy
    rescue
      flash[:alert] = t('errors.destroyed', :model => Customer.model_name.human)
    ensure
      redirect_to customers_path
  end
  
  protected
  def init_customers
    @customers, @customer, @locations, @location, @contacts, @contact = Customer.get_customer_resources(params)
    @show_customer_form, @show_location_form, @show_contact_form = Customer.get_form_visibility(params[:controller], params[:action])
    rescue ActiveRecord::RecordNotFound
      redirect_to customers_path, :alert => t('errors.not_found', :model=> Customer.model_name.human)
  end
  
  def render_filter
    respond_with(@customer) do |format|
      format.html { render "index" }
    end
  end
end
