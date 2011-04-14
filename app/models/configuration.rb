class Configuration < ActiveRecord::Base
  
  include ActiveModel::Validations
  validates :key, :presence => true
  validates :value, :presence => true
  validates :value, :fees => true, :if => Proc.new { |configuration| configuration.key == 'work_fees' }
end
