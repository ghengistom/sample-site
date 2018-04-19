class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :content
      t.integer :rating
      t.string :from_name
      t.string :from_email
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
