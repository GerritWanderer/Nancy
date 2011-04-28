class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.references :user
      t.references :project
      t.string :description
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
