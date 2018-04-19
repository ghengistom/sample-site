class AddDocumentationToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :documentation_url, :string
  end
end
