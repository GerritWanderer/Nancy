class AddUserToWork < ActiveRecord::Migration
  def self.up
		change_table :works do |t|
		    t.references :user
		  end
  end

  def self.down
		remove_column :works, :user_id
  end
end
