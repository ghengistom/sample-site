class AddDllAndDocsInfoToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :dll_paths, :string
    add_column :versions, :namespace, :string
    add_column :versions, :class_name, :string
    add_column :versions, :docs_url, :string
  end
end
