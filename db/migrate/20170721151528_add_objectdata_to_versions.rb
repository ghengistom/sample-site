class AddObjectdataToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :com_object, :string
    add_column :versions, :object_name, :string
  end
end
