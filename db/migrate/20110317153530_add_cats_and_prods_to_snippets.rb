class AddCatsAndProdsToSnippets < ActiveRecord::Migration
  def self.up
    change_table :snippets do |t|
      t.integer :category_id
    end
  end

  def self.down
    change_table :snippets do |t|
      t.remove :category_id
    end
  end
end
