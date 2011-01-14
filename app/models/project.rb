class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact
end
