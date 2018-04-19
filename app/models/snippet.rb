class Snippet < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :attachments
  has_many :snippet_versions, :dependent => :destroy
  has_many :products, :through => :snippet_versions
  
  validates_presence_of :name, :code, :category
  
  before_save :flush_cache
  
  include MultipleProducts
  
  def self.find_all_by_product_id_and_version_sort_order_and_category_id(product_id, sort_order, category_id)
    snippets = self.where(["products.id = ?", product_id])
      .joins(:snippet_versions)
      .joins(:products)
      .joins("LEFT JOIN versions vs ON snippet_versions.version_id_start = vs.id")
      .joins("LEFT JOIN versions ve ON snippet_versions.version_id_end = ve.id")
      .where(["? BETWEEN vs.sort_order AND ifnull(ve.sort_order,999999999)", sort_order])
      .where(["snippet_versions.product_id = ?",product_id])
      .where(:category_id => category_id)
      .order("snippets.name ASC")
  end

  def self.find_all_by_product_id_and_version_sort_order(product_id, sort_order)
    snippets = self.where(["products.id = ?", product_id])
      .joins(:snippet_versions)
      .joins(:products)
      .joins("LEFT JOIN versions vs ON snippet_versions.version_id_start = vs.id")
      .joins("LEFT JOIN versions ve ON snippet_versions.version_id_end = ve.id")
      .where(["? BETWEEN vs.sort_order AND ifnull(ve.sort_order,999999999)", sort_order])
      .where(["snippet_versions.product_id = ?",product_id])
      .order("snippets.name ASC")
  end
  
  protected
  def flush_cache
    # Rails.cache.clear
  end
end
