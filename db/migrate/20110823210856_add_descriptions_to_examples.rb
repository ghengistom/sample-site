class AddDescriptionsToExamples < ActiveRecord::Migration
  class Example < ActiveRecord::Base; end
  def self.up
    add_column :examples, :legacy_documentation, :text
    rename_column :examples, :description, :documentation
    
    Example.all.each do |e|
      puts "Updating #{e.title}..."
      e.legacy_documentation = e.documentation
      e.documentation = nil
      e.save
    end
  end

  def self.down
    remove_column :examples, :legacy_documentation
  end
end
