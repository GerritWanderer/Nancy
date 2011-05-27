class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :title
      t.datetime :started_at
      t.datetime :ended_at
      t.references :project
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
