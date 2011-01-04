class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :salutation
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :department
      t.string :email
      t.string :fon
      t.string :mobile
      t.string :fax
      t.references :location

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
