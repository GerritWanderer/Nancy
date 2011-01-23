class ChangeProjectClosedToInteger < ActiveRecord::Migration
  def self.up
    change_column :projects, :closed, :integer
  end

  def self.down
    change_column :projects, :closed, :boolean
  end
end
