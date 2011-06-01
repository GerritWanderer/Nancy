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
      redirect_to [@customer, @location], :notice => t('successes.created', :model => Contact.model_name.human)
    else
      render 'customers/index'
    end
  end

  def update
    if @contact.update_attributes(params[:contact])
      redirect_to [@customer, @location], :notice => t('successes.updated', :model => Contact.model_name.human)
    else
      render 'customers/index'
    end
  end

  def destroy
    if @location.contacts.delete(@contact)
      flash[:notice] = t('successes.destroyed', :model => Contact.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model => Contact.model_name.human)
    end
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
