class AddDisposeToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :use_dispose, :boolean
  end
end
