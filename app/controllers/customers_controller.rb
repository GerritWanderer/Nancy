class CustomersController < ApplicationController
  before_filter :authenticate_user!, :init_customers
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :mobile

  def index #empty method? I should be doing a something more then in init_customers
  end

  def show #empty method? I should be doing a something more then in init_customers
  end

  def new #empty method? I should be doing a something more then in init_customers
  end

  def edit
    @locations = Location.where('customer_id = ?', @customer.id),order('created_at ASC')
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      if Customer.count == 1
        project = Project.new({:title => "Nancy: First look", :description => "Setup Nancy and try out the features", :customer_id => @customer.id, :contact_id => @customer.locations.first.contacts.first.id, :closed => 0}).save
        flash[:notice] = 'Great, you finished the setup...Nancy is now ready for use - have phun!'
        redirect_to :controller => 'works', :action => 'index'
      else
        flash[:notice] = 'Customer was successfully created.'
        respond_with(@customer)
      end
    else
      @form_customer = @customer
      render "index"
    end
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = 'Customer was successfully updated.'
      respond_with(@customer)
    else
      @form_customer = @customer
      render "index"
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      flash[:notice] = 'Customer was successfully deleted.'
    else
      flash[:alert] = 'Customer was not deleted.'
    end
    redirect_to(customers_url)
  end
  
  def first
    @form_customer = Customer.new
    @form_location = @form_customer.locations.build
    @form_contact = @form_location.contacts.build
    render :layout => "users", :action => "customers/_form_for_first"
  end
  
  protected
  def init_customers
    @customers = Customer.order(params[:order])
    if params[:id]
      @customer = Customer.find(params[:id])
      @locations = @customer.locations
      @location = @locations.first
      @contacts = @location.contacts
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
