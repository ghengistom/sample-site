class AddHumanCheckToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :human_check, :integer
  end
end
