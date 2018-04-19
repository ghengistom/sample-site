class AddBetaToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :beta, :boolean
  end
end
