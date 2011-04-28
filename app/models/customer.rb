class Customer < ActiveRecord::Base
  has_many :locations, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  accepts_nested_attributes_for :locations, :allow_destroy => true
  
  validates :name, :length => {:minimum => 3, :maximum => 254}
  validates :shortname, :length => {:minimum => 3, :maximum => 254}
  
  scope :with_active_projects, where("closed = ?", 0).order("name ASC")
  
  def self.find_previous_customer(customer_id)
    hit = false
    previous_customer = 0
    Customer.order("name desc").each do |customer|
      if hit
        previous_customer = customer.id
        break
      end
      hit = true if customer.id == customer_id
    end
    return previous_customer
  end
  
  def self.get_customer_records(params)
    customers = Customer.order(params[:order])
    if params[:id] || params[:customer_id]
      if params[:location_id] && params[:customer_id]
        location = Location.find(params[:location_id])
        customer = location.customer
      elsif params[:customer_id]
        location = Location.find(params[:customer_id])
        customer = location.customer
      elsif params[:id]
        customer = Customer.find(params[:id])
        location = customer.locations.first
      end
      locations = customer.locations
      contacts = location.contacts
    else
      customer = Customer.new
    end
    return customers, customer, locations, location, contacts
  end
  
  def self.get_customerform_variables(customer)
    form_customer = customer
    form_location = form_customer.locations.build
    form_contact = form_location.contacts.build
    return form_customer, form_location, form_contact
  end
  
  def self.get_form_visibility(controller, action)
    customer_form = controller == 'customers' && ['new', 'edit', 'create', 'update'].index(action) ? true : false
    location_form = controller == 'customers/locations' && ['new', 'edit', 'create', 'update'].index(action) ? true : false
    contact_form = controller == 'contacts' && ['new', 'edit', 'create', 'update'].index(action) ? true : false
    return customer_form, location_form, contact_form
  end
end