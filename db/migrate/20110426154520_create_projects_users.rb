class CreateProjectsUsers < ActiveRecord::Migration
  def self.up
    create_table :projects_users, :id => false do |t|
      t.references :user, :project
    end
    add_index "projects_users", "user_id"
    add_index "projects_users", "project_id"
  end

  def self.down
    drop_table :projects_users
  end
end