class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.date :date_from
			t.date :date_to
      t.integer :type_of_day
      t.integer :verified
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :days
  end
end
