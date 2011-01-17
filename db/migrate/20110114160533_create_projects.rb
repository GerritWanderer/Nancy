class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.float :discount
      t.float :budget
      t.integer :type
      t.boolean :closed
      t.references :customer
      t.references :contact

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
