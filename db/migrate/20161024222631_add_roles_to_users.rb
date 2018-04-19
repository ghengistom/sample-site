class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qa, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
    add_column :users, :support, :boolean, default: false
    add_column :users, :engineering, :boolean, default: false
  end
end
