class CustomersController < ApplicationController
  before_filter :authenticate_user!, :init_customers
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :js, :mobile

  def index # see init_customers
  end

  def show # see init_customers
  end

  def new # see init_customers
  end

  def edit
    @locations = Location.where('customer_id = ?', @customer.id),order('created_at ASC')
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:notice] = t('successes.created', :model=> Customer.model_name.human)
      respond_with(@customer)
    else
      @form_customer = @customer
      render "index"
    end
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = t('successes.updated', :model=> Customer.model_name.human)
      respond_with(@customer)
    else
      @form_customer = @customer
      render "index"
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      flash[:notice] = t('successes.destroyed', :model=> Customer.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model=> Customer.model_name.human)
    end
    redirect_to(customers_url)
  end

  protected
  def init_customers
    @customers = Customer.order(params[:order])
    if params[:id]
      if Customer.exists?(params[:id])
        @customer = Customer.find(params[:id])
          @locations = @customer.locations
          @location = @locations.first
          @contacts = @location.contacts
      else
        flash.now[:alert] = 'Customer Does not exist'
      end
    else
      @customer = Customer.new
    end
    
    if params[:action] == 'edit'
      @form_customer = @customer
    else
      @form_customer = Customer.new
      @form_location = @form_customer.locations.build
      @form_contact = @form_location.contacts.build
    end
    
    @displayCustomerForm = params[:action] == 'new' || params[:action] == 'edit' || params[:action] == 'create' || params[:action] == 'update'? 'block' : 'none'
  end
  
  def render_filter
    respond_with(@customer) do |format|
      format.html { render "index" }
    end
  end
end
