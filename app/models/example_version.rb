class ExampleVersion < ActiveRecord::Base
  belongs_to :product
  belongs_to :example
  belongs_to :version_start, :foreign_key => 'version_id_start', :class_name => Version
  belongs_to :version_end, :foreign_key => 'version_id_end', :class_name => Version
  
  # validates_uniqueness_of :product_id, :scope => :example_id
  # validates_presence_of :product, :example
end
