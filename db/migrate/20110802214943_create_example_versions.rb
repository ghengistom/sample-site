class CreateExampleVersions < ActiveRecord::Migration
  def self.up
    create_table :example_versions do |t|
      t.integer :product_id
      t.integer :example_id
      t.integer :version_id_start
      t.integer :version_id_end

      t.timestamps
    end
    
    Example.all.each do |e|
      ExampleVersion.create(:product_id => e.product_id, :example_id => e.id, :version_id_start => e.version_id_start, :version_id_end => e.version_id_end)
    end
    
    change_table :examples do |t|
      t.remove :product_id, :version_id_start, :version_id_end
    end
  end

  def self.down
    drop_table :example_versions
  end
end
