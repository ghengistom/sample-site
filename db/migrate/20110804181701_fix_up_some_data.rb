class FixUpSomeData < ActiveRecord::Migration
  class Example < ActiveRecord::Base
    has_many :example_versions, :dependent => :destroy
    has_many :products, :through => :example_versions
  end
  class ExampleVersion < ActiveRecord::Base
    belongs_to :example
    belongs_to :product
  end
  class Product < ActiveRecord::Base
    has_many :example_versions, :dependent => :destroy
    has_many :examples, :through => :example_versions
  end
  
  def self.up
    ExampleVersion.all.each do |ev|
      puts "Updating #{ev.example.title} version end id."
      ev.version_id_end = nil if ev.version_id_end == 0
      ev.save
    end
    
    Example.all.each do |e|
      if e.products.map{|p| p.id}.include?(2)
        puts "Removing WG WBE example - #{e.title}"
        e.destroy
      end
    end
    
    ExampleVersion.where(:product_id => 14).each do |ev|
      puts "Updating WG E example #{ev.example.title} to WG WBE"
      new_ev = ExampleVersion.new(ev.attributes)
      new_ev.product_id = 2
      new_ev.save
    end
    
    ExampleVersion.where(:product_id => 7).each do |ev|
      unless ev.example.description && ev.example.description.match(/Pro\./)
        puts "Adding TK PRO example to TK STD - #{ev.example.title}" 
        ExampleVersion.create do |tk|
          tk.product_id = 15
          tk.example_id = ev.example_id
          tk.version_id_start = ev.version_id_start
          tk.version_id_end = ev.version_id_end
        end
      end
    end
  end

  def self.down
  end
end
