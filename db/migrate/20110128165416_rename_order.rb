class RenameOrder < ActiveRecord::Migration
  def self.up
    rename_column :versions, :order, :sort_order
  end

  def self.down
  end
end
