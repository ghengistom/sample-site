class AddPs1ToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :ps1, :boolean
  end
end
