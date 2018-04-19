class AddBuildsToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :builds, :string
  end
end
