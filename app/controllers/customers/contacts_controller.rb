class Customers::ContactsController < ApplicationController
  before_filter :authenticate_user!, :init_contacts
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  
  def index #empty method? I should be doing something more then in init_contacts
  end
  
  def show #empty method? I should be doing something more then in init_contacts
  end

  def new #empty method? I should be doing something more then in init_contacts
  end

  def edit #empty method? I should be doing something more then in init_contacts
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash.now[:notice] = 'Contact was successfully created.'
    else
      @form_contact = @contact
      @displayContactsRecord = 'none'
      @displayContactsForm = 'block'
    end
    render :template => 'customers/index'
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash.now[:notice] = 'Contact was successfully updated.'
    else
      @form_contact = @contact
      @displayContactsRecord = 'none'
      @displayContactsForm = 'block'
    end
    render :template => 'customers/index'
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact.destroy
      redirect_to customer_location_path(@customer, @location)
    end
  end
  
  protected
  
  def init_contacts
    @customers = Customer.order(params[:order])
    @customer = Customer.find(params[:customer_id])
    @locations = @customer.locations
    @location = Location.find(params[:location_id])
    @contacts = @location.contacts
    @contact = params[:id] ? Contact.find(params[:id]) : Contact.new
    
    @form_customer = Customer.new
    @form_location = @form_customer.locations.build
    @form_contact = params[:action] == 'edit' ? @contact : @form_location.contacts.build
    
    if params[:action] == 'edit' || params[:action] == 'new'
      @displayContactsRecord = 'none'
      @displayContactForm = 'block'
    end
  end
  
  def render_filter
    render :template => 'customers/index'
  end
end
