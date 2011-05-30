class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact
  has_many :works, :dependent => :delete_all
  has_many :expenses, :dependent => :delete_all
  has_many :invoices, :dependent => :delete_all
  has_and_belongs_to_many :users
  
  validates :title, :presence => true, :length => {:minimum => 3, :maximum => 254}
  validates_presence_of :description, :message => "Description can't be blank"
  
  attr_accessor :tax, :work_net_sum, :work_hour_sum, :work_discount_sum, :expense_sum, :full_net_sum, :tax_sum, :full_tax_sum
  
  scope :by_customer_isClosed, proc {|customer, status| where(:customer_id => customer, :closed => status).order('title ASC') }
  scope :isClosed, lambda {|status| {:conditions => {:closed => status}}}
  
  
  def self.get_resources(params, current_user)  
    if params[:project_id]
      project = Project.find(params[:project_id])
    else
      project = params[:id] ? Project.find(params[:id]) : Project.new
    end
    
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
    return projects, project, customers, customer, contacts, contact, project_tab
  end
  
  def self.get_visibility_options(controller, action)
    form_actions = ['new', 'edit', 'create']
    project_form = controller == 'projects' && form_actions.index(action) ? true : false
    expense_form = controller == 'projects/expenses' && form_actions.index(action) ? true : false
    invoice_form = controller == 'projects/invoices' && form_actions.index(action) ? true : false
    return project_form, expense_form, invoice_form
  end
  
  def get_invoice_dates
    started_at = self.invoices.empty? ? self.works.first.started_at : self.invoices.last.ended_at
    ended_at = self.works.last.ended_at
    return started_at, ended_at
  end
  
  def get_childs_range(started_at, ended_at)
    if started_at && ended_at
      works = self.works.in_range(started_at, ended_at) 
      expenses = self.expenses.in_range(started_at, ended_at)
    else
      works = self.works.find(:all, :include => :user)
      expenses = self.expenses.find(:all, :include => :user)
    end
    return works, expenses
  end

  def set_sums(works, expenses)
    self.tax = Configuration.find_by_key('tax').value.to_f
    # Sum each work with duration and fee
    self.work_net_sum = 0
    self.work_hour_sum = 0
    self.expense_sum = 0
    works.each do |work|
      self.work_hour_sum += work.duration.to_f / 60
      self.work_net_sum += (work.duration.to_f / 60) * work.fee
    end
    self.work_discount_sum = 0 - (self.work_net_sum * (self.discount / 100))
    
    expenses.each do |expense|
      self.expense_sum += expense.amount
    end
    
    # add discount and tax sums
    self.full_net_sum = self.work_net_sum + self.work_discount_sum + self.expense_sum
    self.tax_sum = self.full_net_sum * (self.tax / 100)
    self.full_tax_sum = self.full_net_sum + self.tax_sum
  end
end
