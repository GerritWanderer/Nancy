class LocationsController < ApplicationController
  before_filter :authenticate_user!, :init_locations
  
  def index
    @locations = Location.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  def show
    render :layout => 'customers', :template => 'customers/show'
  end

  def new
    render :layout => 'customers', :template => 'customers/show'
  end

  def edit
    render :layout => 'customers', :template => 'customers/show'
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      render :layout => 'customers', :template => 'customers/show'
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      render :layout => 'customers', :template => 'customers/show'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      redirect_to customer_location_path(@customer, @customer.locations.first)
    end
  end
  
  protected
  def init_locations
    params[:order] ? @customers = Customer.find(:all, :order => params[:order]) : @customers = Customer.all
    @customer = Customer.find(params[:customer_id])
    @locations = @customer.locations
    params[:id] ? @location = Location.find(params[:id]) : @location = @customer.locations.first
    @contacts = @location.contacts
    
    @form_customer = Customer.new
    params[:action] == 'edit' ? @location_build = @location : @location_build = @form_customer.locations.build
    @location_build_temp = @form_customer.locations.build
    @contact_build = @location_build_temp.contacts.build
    if params[:action] == 'edit' || params[:action] == 'new'
      @displayLocationRecord = 'none'
      @displayLocationForm = 'block'
    end
  end
end