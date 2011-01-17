class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.datetime :start
      t.datetime :end
      t.integer :duration
      t.text :description
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :works
  end
end
