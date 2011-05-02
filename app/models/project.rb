class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact
  has_many :works, :dependent => :delete_all
  has_and_belongs_to_many :users
  
  validates :title, :presence => true, :length => {:minimum => 3, :maximum => 254}
  validates_presence_of :description, :message => "Description can't be blank"
  
  attr_accessor :tax, :work_sum, :net_sum, :discount_sum, :full_net_sum, :tax_sum, :full_tax_sum
  
  scope :by_customer_isClosed, proc {|customer, status| where(:customer_id => customer, :closed => status).order('title ASC') }
  scope :isClosed, lambda {|status| {:conditions => {:closed => status}}}
  
  def self.get_view_objects(params, current_user)
    project = params[:id] ? Project.find(params[:id]) : Project.new
    
    if params[:closed].to_i == 1 || project.closed == 1
      projects = Project.isClosed(1).joins(:customer).order(params[:order])
      project_tab = 'closed'
    else
      if project.users.exists?(current_user.id) || (params[:id].nil? && params[:closed].nil?)
        projects = Project.isClosed(0).joins(:customer, :users).where("users.id" => current_user.id).order(params[:order])
        project_tab = 'subscribed'
      else
        projects = Project.isClosed(0).joins(:customer).order(params[:order])
        project_tab = 'active'
      end
    end
    return projects, project, project_tab
  end
  
  def self.get_form_objects(params)
    customers = Customer.all
    contacts = []
    if customers.empty?
      customer = Customer.new
      contact = Contact.new
    else
      customer = params[:customer_id] ? Customer.find(params[:customer_id]) : customers.first
      contact = params[:contact_id] ? Contacts.find(params[:contact_id]) : customer.locations.first.contacts.first
      customer.locations.each {|location| location.contacts.each {|contact| contacts.push(contact)}}
    end
    show_project_form = ['new', 'edit', 'create'].index(params[:action]) ? true : false
    return customers, customer, contacts, contact, show_project_form
  end
  
  def set_sums
    self.tax = Configuration.find_by_key('tax').value.to_f
    # Sum each work with duration and fee
    self.work_sum = 0
    self.net_sum = 0
    self.works.each do |work|
      self.work_sum += work.duration.to_f / 60
      self.net_sum += self.work_sum * work.fee
    end
    # add discount and tax sums
    self.discount_sum = self.net_sum * (self.discount / 100)
    self.full_net_sum = self.net_sum - self.discount_sum
    self.tax_sum = self.full_net_sum * (self.tax / 100)
    self.full_tax_sum = self.full_net_sum + self.tax_sum
  end
end
