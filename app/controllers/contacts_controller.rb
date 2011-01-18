class ContactsController < ApplicationController
  before_filter :authenticate_user!, :init_contacts
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  
  def index #empty method? I should be doing a something more then in init_contacts
  end
  
  def show #empty method? I should be doing a something more then in init_contacts
  end

  def new #empty method? I should be doing a something more then in init_contacts
  end

  def edit #empty method? I should be doing a something more then in init_contacts
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      render :layout => 'customers', :template => 'customers/show'
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      render :layout => 'customers', :template => 'customers/show'
    end
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
    render :layout => 'customers', :template => 'customers/show'
  end
end
