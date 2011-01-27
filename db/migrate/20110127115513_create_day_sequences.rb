class CreateDaySequences < ActiveRecord::Migration
  def self.up
    create_table :day_sequences do |t|
      t.date :date
      t.integer :type
      t.integer :verified
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :day_sequences
  end
end
