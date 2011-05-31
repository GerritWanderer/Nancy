class AddTextTemplateToWork < ActiveRecord::Migration
  def self.up
    add_column :works, :text_template_id, :integer
  end

  def self.down
    remove_column :works, :text_template_id
  end
end
