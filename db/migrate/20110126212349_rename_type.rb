class RenameType < ActiveRecord::Migration
  def self.up
    rename_column :examples, :type, :example_type
  end

  def self.down
  end
end
