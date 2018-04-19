class AddLanguagesToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :html, :boolean
    add_column :examples, :shell, :boolean
  end
end
