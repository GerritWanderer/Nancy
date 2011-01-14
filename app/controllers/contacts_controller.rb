class ContactsController < ApplicationController
  before_filter :init_contacts
  
  def show
    render :layout => 'customers', :template => 'customers/show'
  end

  def new
    render :layout => 'customers', :template => 'customers/show'
  end

  def edit
    @contact = Contact.find(params[:id])
    render :layout => 'customers', :template => 'customers/show'
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
    params[:order] ? @customers = Customer.find(:all, :order => params[:order]) : @customers = Customer.all
    @customer = Customer.find(params[:customer_id])
    @locations = @customer.locations
    @location = Location.find(params[:location_id])
    @contacts = @location.contacts
    params[:id] ? @contact = Contact.find(params[:id]) : Contact.new
    
    @form_customer = Customer.new
    @location_build = @form_customer.locations.build
    params[:action] == 'edit' ? @contact_build = @contact : @contact_build = @location_build.contacts.build
    
    if params[:action] == 'edit' || params[:action] == 'new'
      @displayContactsRecord = 'none'
      @displayContactForm = 'block'
    end
  end
end
