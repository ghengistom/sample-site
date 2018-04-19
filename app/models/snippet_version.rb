class SnippetVersion < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :product
  
  # validates_uniqueness_of :product_id, :scope => :example_id
  # validates_presence_of :product, :example
end
