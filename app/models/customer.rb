class Customer < ActiveRecord::Base
  has_many :locations
  has_many :projects
  accepts_nested_attributes_for :locations, :allow_destroy => true
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :shortname, :message => "can't be blank"
  
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
end