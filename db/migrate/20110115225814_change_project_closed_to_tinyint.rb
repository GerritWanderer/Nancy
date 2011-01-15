class ChangeProjectClosedToTinyint < ActiveRecord::Migration
  def self.up
    change_column :projects, :closed, :tinyint
  end

  def self.down
    change_column :projects, :closed, :boolean
  end
end
