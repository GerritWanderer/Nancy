class Customers::LocationsController < ApplicationController
  before_filter :authenticate_user!, :init_locations
  before_filter :render_filter, :only => [:show, :new, :edit]

  def show # see init_locations
  end

  def new # see init_locations
  end

  def edit # see init_locations
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
    @customers, @customer, @locations, @location, @contacts = Customer.get_customer_records(params)
    @form_customer, @form_location, @form_contact = Customer.get_customerform_variables(@customer)
    @show_customer_form, @show_location_form, @show_contact_form = Customer.get_form_visibility(params[:controller], params[:action])
    rescue ActiveRecord::RecordNotFound
      redirect_to customers_path, :alert => t('errors.not_found', :model=> Location.model_name.human)
  end
  
  def render_filter
    render :template => 'customers/index'
  end
end