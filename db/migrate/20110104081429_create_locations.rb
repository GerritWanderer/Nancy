class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :street
      t.integer :zip
      t.string :city
      t.string :fon
      t.string :fax
      t.references :customer

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
