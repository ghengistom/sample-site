class RenameLanguages < ActiveRecord::Migration
  def self.up
    rename_column :examples, :vbnet, :vb
    rename_column :examples, :ruby, :rb
  end

  def self.down
  end
end
