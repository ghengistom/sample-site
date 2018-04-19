class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :name
      t.string :mime

      t.timestamps
    end
    
    create_table :attachments_examples, :id => false do |t|
      t.string :attachment_id
      t.string :example_id
    end
  end

  def self.down
    drop_table :attachments
    drop_table :attachments_examples
  end
end
