class AddStatusToExamples < ActiveRecord::Migration
  
  class Example < ActiveRecord::Base; end
  
  def self.up
    add_column :examples, :status, :string, :default => "in progress"
    Example.reset_column_information
    
    Example.where(:category_id => 5).each do |e|
      e.status = "inactive"
      e.save
      say "Set #{e.title} to inactive."
    end
  end

  def self.down
    remove_column :examples, :status
  end
end
