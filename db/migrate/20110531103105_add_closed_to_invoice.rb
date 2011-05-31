class AddClosedToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :closed, :integer, :default => 0
  end

  def self.down
    remove_column :invoices, :closed
  end
end
