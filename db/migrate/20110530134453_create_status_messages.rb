class CreateStatusMessages < ActiveRecord::Migration
  def self.up
    create_table :status_messages do |t|
      t.string :title
      t.references :project
      t.references :user
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :status_messages
  end
end
