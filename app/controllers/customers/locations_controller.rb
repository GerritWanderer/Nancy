class Customers::LocationsController < ApplicationController
  before_filter :authenticate_user!, :init_locations
  before_filter :render_filter, :only => [:show, :new, :edit]

  def index # see init_locations
    redirect_to @customer
  end
  
  def show # see init_locations
  end
  
  def new # see init_locations
  end

  def edit # see init_locations
  end

  def create
    @location = @customer.locations.build(params[:location])
    if @location.save
      redirect_to [@customer, @location], :notice => t('successes.created', :model=> Location.model_name.human)
    else
      render 'customers/index'
    end
  end

  def update
    begin
      @location = @customer.locations.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to @customer, :alert => t('errors.not_found', :model=> Location.model_name.human)
    end
    if @location.update_attributes(params[:location])
      redirect_to [@customer, @location], :notice => t('successes.updated', :model=> Location.model_name.human)
    else
      render 'customers/index'
    end
  end

  def destroy
    flash[:notice] = t('successes.destroyed', :model=> Location.model_name.human) if @customer.locations.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = t('errors.destroyed', :model=> Location.model_name.human)
    ensure
      redirect_to @customer
  end
  
  protected
  def init_locations
    @customers, @customer, @locations, @location, @contacts, @contact = Customer.get_customer_resources(params)
    @show_customer_form, @show_location_form, @show_contact_form = Customer.get_form_visibility(params[:controller], params[:action])
    rescue ActiveRecord::RecordNotFound
      redirect_to customers_path, :alert => t('errors.not_found', :model=> Location.model_name.human)
  end
  
  def render_filter
    render 'customers/index'
  end
end