class Category < ActiveRecord::Base
  has_many :examples
  has_many :snippets
  validates_uniqueness_of :name
  validates_presence_of :name
  
  scope :with_snippets, -> { joins(:snippets).uniq }

  def snippets_by_product_id_and_version_sort_order(product_id, version_sort_order)
    Snippet.find_all_by_product_id_and_version_sort_order_and_category_id product_id, version_sort_order, id
  end
end
