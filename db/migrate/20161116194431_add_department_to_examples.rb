class AddDepartmentToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :department, :string
  end
end
