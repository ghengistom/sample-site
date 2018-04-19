class SnippetsVersions < ActiveRecord::Migration
    def self.up
      create_table :snippet_versions do |t|
        t.integer :product_id
        t.integer :snippet_id
        t.integer :version_id_start
        t.integer :version_id_end

        t.timestamps
      end

      Snippet.all.each do |s|
        s.version_id_end = nil if s.version_id_end == 0
        SnippetVersion.create(:product_id => s.product_id, :snippet_id => s.id, :version_id_start => s.version_id_start, :version_id_end => s.version_id_end)
        puts "Updated snippet: #{s.id}"
      end

      change_table :snippets do |t|
        t.remove :product_id, :version_id_start, :version_id_end
      end
    end

  def self.down
    drop_table "snippets_versions"
  end
end
