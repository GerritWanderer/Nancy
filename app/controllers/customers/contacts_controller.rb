class Customers::ContactsController < ApplicationController
  before_filter :authenticate_user!, :init_contacts
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  
  def index # see init_contacts
  end
  
  def show # see init_contacts
  end

  def new # see init_contacts
  end

  def edit # see init_contacts
  end

  def create
    @contact = @location.contacts.build(params[:contact])
    if @contact.save
      flash.now[:notice] = t('successes.created', :model=> Contact.model_name.human)
      @show_contact_form = false
    end
    render 'customers/index'
  end

  def update
    begin
      @contact = @location.contacts.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to [@customer, @location], :alert => t('errors.not_found', :model=> Contact.model_name.human)
    end
    if @contact.update_attributes(params[:contact])
      flash.now[:notice] = t('successes.updated', :model=> Contact.model_name.human)
      @show_contact_form = false
    end
    render 'customers/index'
  end

  def destroy
    flash[:notice] = t('successes.destroyed', :model=> Contact.model_name.human) if @location.contacts.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = t('errors.destroyed', :model=> Contact.model_name.human)
    ensure
      redirect_to [@customer, @location]
  end
  
  protected
  def init_contacts
    @customers, @customer, @locations, @location, @contacts, @contact = Customer.get_customer_resources(params)
    @show_customer_form, @show_location_form, @show_contact_form = Customer.get_form_visibility(params[:controller], params[:action])
    rescue ActiveRecord::RecordNotFound
      redirect_to customers_path, :alert => t('errors.not_found', :model=> Location.model_name.human)
  end
  
  def render_filter
    render :template => 'customers/index'
  end
end
