class AddDisplayTitleToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :display_title, :text
  end
end
