class AttachmentsSnippets < ActiveRecord::Migration
  def self.up
    create_table "attachments_snippets", :id => false do |t|
      t.string "attachment_id"
      t.string "snippet_id"
    end
  end

  def self.down
    drop_table "attachments_snippets"
  end
end
