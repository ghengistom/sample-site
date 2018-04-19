class AddVideoLinkToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :video, :string
  end
end
