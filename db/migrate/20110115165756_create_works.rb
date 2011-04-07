class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.datetime :started_at
      t.datetime :ended_at
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
