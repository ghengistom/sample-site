class ChangeCFtoCfm < ActiveRecord::Migration
  def self.up
    rename_column :examples, :cf, :cfm
  end

  def self.down
    rename_column :products, :cfm, :cf
  end
end
