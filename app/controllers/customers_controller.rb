class CustomersController < ApplicationController
  before_filter :authenticate_user!, :init_customers
  load_and_authorize_resource :except => [:index, :show] 
  before_filter :render_filter, :only => [:index, :show, :new, :edit]
  respond_to :html, :mobile

  def index #empty method? I should be doing a something more then in init_customers
  end

  def show #empty method? I should be doing a something more then in init_customers
  end

  def new #empty method? I should be doing a something more then in init_customers
  end

  def edit
    @locations = Location.where('customer_id = ?', @customer.id),order('created_at ASC')
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:notice] = t('successes.created', :model=> Customer.model_name.human)
      respond_with(@customer)
    else
      @form_customer = @customer
      render "index"
    end
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = t('successes.updated', :model=> Customer.model_name.human)
      respond_with(@customer)
    else
      @form_customer = @customer
      render "index"
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      flash[:notice] = t('successes.destroyed', :model=> Customer.model_name.human)
    else
      flash[:alert] = t('errors.destroyed', :model=> Customer.model_name.human)
    end
    redirect_to(customers_url)
  end
  
  def new_first_customer
    @form_customer = Customer.new
    @form_location = @form_customer.locations.build
    @form_contact = @form_location.contacts.build
    render :layout => "users", :template => "customers/_form_for_first"
  end
  
  def create_first_customer
    @customer = Customer.new(params[:customer])
    if @customer.save
      project = Project.create!({ :title => "Nancy: First look",
                                  :description => "Setup Nancy and try out some features",
                                  :customer_id => @customer.id,
                                  :contact_id => @customer.locations.first.contacts.first.id,
                                  :closed => 0})
      Work.create!( :start_datetime => Time.now.-(30*60).strftime('%Y-%m-%d %H:%M'),
                    :end_datetime => Time.now.strftime('%Y-%m-%d %H:%M'),
                    :description => "Install Nancy and create initial customer/project",
                    :project_id => project.id,
                    :user_id => current_user.id)
      redirect_to works_path, :notice => 'Great, you finished the setup...Nancy is now ready for use - have phun!'
    else
      render :layout => "users", :template => "customers/_form_for_first", :alert => 'An error occured while saving the first Customer'
    end
  end
  
  protected
  def init_customers
    @customers = Customer.order(params[:order])
    if params[:id]
      @customer = Customer.find(params[:id])
      @locations = @customer.locations
      @location = @locations.first
      @contacts = @location.contacts
    else
      @customer = Customer.new
    end
    
    if params[:action] == 'edit'
      @form_customer = @customer
    else
      @form_customer = Customer.new
      @form_location = @form_customer.locations.build
      @form_contact = @form_location.contacts.build
    end
    
    @displayCustomerForm = params[:action] == 'new' || params[:action] == 'edit' || params[:action] == 'create' || params[:action] == 'update'? 'block' : 'none'
  end
  
  def render_filter
    respond_with(@customer) do |format|
      format.html { render "index" }
    end
  end
end
