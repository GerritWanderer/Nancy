class CustomersController < ApplicationController
  before_filter :init_customers
  respond_to :html, :js

  def index
    #see before_filter function init_customers
    respond_with(@customers)
  end

  def show
    #see before_filter function init_customers
    respond_with(@customer) do |format|
      format.html { render "index" }
    end
  end

  def new
    #see before_filter function init_customers
    respond_with(@customer) do |format|
      format.html { render "index" }
    end
  end

  def edit
    #see before_filter function init_customers
    @locations = Location.paginate :conditions => ['customer_id = ?', @customer.id], :page => params[:page], :order => 'created_at ASC'
    respond_with(@customer) do |format|
      format.html { render "index" }
    end
  end

  def create
    @customer = Customer.new(params[:customer])
    respond_to do |format|
      if @customer.save
        format.html { redirect_to(@customer, :notice => 'Customer was successfully created.') }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end
  def update
    @customer = Customer.find(params[:id])
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to(@customer, :notice => 'Customer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def init_customers
    @customers = Customer.all
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
      @location_build = @form_customer.locations.build
      @contact_build = @location_build.contacts.build
    end
    
    params[:action] == 'edit' ? @displayCustomerForm = 'block' : @displayCustomerForm = 'none'
  end
end
