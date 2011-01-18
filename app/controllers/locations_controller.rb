class LocationsController < ApplicationController
  before_filter :authenticate_user!, :init_locations
  before_filter :render_filter, :only => [:show, :new, :edit]
  
  #mhh, index method is not used

  def show #empty method? I should be doing a something more then in init_locations
  end

  def new #empty method? I should be doing a something more then in init_locations
  end

  def edit #empty method? I should be doing a something more then in init_locations
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
    @customers = Customer.order(params[:order])
    @customer = Customer.find(params[:customer_id])
    @locations = @customer.locations
    @location = params[:id] ? Location.find(params[:id]) : @customer.locations.first
    @contacts = @location.contacts
    
    @form_customer = Customer.new
    @form_location = params[:action] == 'edit' ? @location : @form_customer.locations.build
    @form_location_temp = @form_customer.locations.build
    @form_contact = @form_location_temp.contacts.build
    if params[:action] == 'edit' || params[:action] == 'new'
      @displayLocationRecord = 'none'
      @displayLocationForm = 'block'
    end
  end
  
  def render_filter
    render :layout => 'customers', :template => 'customers/show'
  end
end