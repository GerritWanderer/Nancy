class Customers::LocationsController < ApplicationController
  before_filter :authenticate_user!, :init_locations
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:show, :new, :edit]

  def show #empty method? I should be doing something more then in init_locations
  end

  def new #empty method? I should be doing something more then in init_locations
  end

  def edit #empty method? I should be doing something more then in init_locations
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      flash.now[:notice] = t('successes.created', :model=> Location.model_name.human)
    else
      @form_location = @location
      @location = @customer.locations.first
      @displayLocationRecord = 'none'
      @displayLocationForm = 'block'
    end
    render :template => 'customers/index'
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash.now[:notice] = t('successes.updated', :model=> Location.model_name.human)
    else
      @form_location = @location
      @location = @customer.locations.first
      @displayLocationRecord = 'none'
      @displayLocationForm = 'block'
    end
    render :template => 'customers/index'
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
    render :template => 'customers/index'
  end
end