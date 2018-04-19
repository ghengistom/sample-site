class AddStatusToProductVersions < ActiveRecord::Migration
  def change
    change_table :versions do |t|
      t.string :status
    end
    
    Version.reset_column_information
    
    Version.all.each do |v|
      v.status = if v.name == "2013"
        "future"
      else
        "active"
      end
      v.save
    end
  end
end
