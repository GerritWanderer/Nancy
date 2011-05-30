class StatusMessage < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  has_attached_file :attachment
end
