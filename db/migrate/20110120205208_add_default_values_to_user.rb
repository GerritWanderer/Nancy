class AddDefaultValuesToUser < ActiveRecord::Migration
  def self.up
    change_column :users, :hours, :float, :default => 8
    change_column :users, :holidays, :integer, :default => 30
  end

  def self.down
    change_column :users, :hours, :float, :default => nil
    change_column :users, :holidays, :integer, :default => nil
  end
end