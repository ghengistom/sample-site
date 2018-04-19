class CreateExamples < ActiveRecord::Migration
  def self.up
    create_table :examples do |t|
      t.string :type
      t.text :description
      t.string :title
      t.boolean :is_method
      t.integer :product_id
      t.integer :version_id_start
      t.integer :version_id_end
      t.text :code
      t.string :created_by
      t.string :edited_by
      t.boolean :vbs
      t.boolean :asp
      t.boolean :php
      t.boolean :cf
      t.boolean :cs
      t.boolean :vbnet
      t.boolean :ruby

      t.timestamps
    end
  end

  def self.down
    drop_table :examples
  end
end
