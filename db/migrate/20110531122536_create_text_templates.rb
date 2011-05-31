class CreateTextTemplates < ActiveRecord::Migration
  def self.up
    create_table :text_templates do |t|
      t.string :kind
      t.string :title
      t.integer :parent_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :text_templates
  end
end
