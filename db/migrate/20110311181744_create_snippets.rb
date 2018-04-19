class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.string :name
      t.text :code
      t.integer :product_id
      t.integer :version_id_start
      t.integer :version_id_end

      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
