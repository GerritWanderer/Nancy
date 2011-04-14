class AddFeeToWork < ActiveRecord::Migration
  def self.up
    add_column :works, :fee, :float, :default => 0.00
  end

  def self.down
    remove_column :works, :fee
  end
end
