class CloneExamples < ActiveRecord::Migration
  def self.up
    add_column :examples, :clone_id ,:integer
  end

  def self.down
    remove_column :examples, :clone_id
  end
end
