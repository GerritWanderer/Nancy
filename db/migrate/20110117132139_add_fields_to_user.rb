class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :hours, :float
    add_column :users, :holidays, :integer
  end

  def self.down
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :hours
    remove_column :users, :holidays
  end
end
