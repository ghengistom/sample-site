class Version < ActiveRecord::Base
  belongs_to :product
  
  scope :active, -> { where(:status => 'active').order('sort_order DESC') }
  scope :future, -> { where(:status => 'future').order('sort_order DESC') }
  scope :legacy, -> { where(:status => 'legacy').order('sort_order DESC') }
  scope :active_or_future, -> { where("status = 'active' OR status = 'future'").order('sort_order DESC') }

  validate :sort_order_must_be_less_than_a_max
  validate :status_must_be_one_of_three
  
  validates_presence_of :name, :sort_order, :product
  validates :sort_order, :numericality => true, :uniqueness => {:scope => :product_id}
  
  def sort_order_must_be_less_than_a_max
    errors.add(:sort_order, "can't be more than 999999998") if
      sort_order > 999999998
  end
  
  def status_must_be_one_of_three
    errors.add :status, "must be one of: active, legacy, or future" unless
      ['active', 'legacy', 'future'].include?(status)
  end
  
  def snippets
    Snippet.find_all_by_product_id_and_version_sort_order(product.id, sort_order)
  end

  def snippet_categories
    cats = []
    snippets.group('snippets.category_id').each do |s|
      cats << s.category
    end
    cats.uniq.sort_by{|id| Category.find(id).name }
  end

  def self.find_by_product_id_between_version_ids(product_id, first_version_id, last_version_id)
    last_version_id = Version.where(:product_id => product_id).last.id unless last_version_id
    
    first = Version.find(first_version_id).sort_order
    last = Version.find(last_version_id).sort_order
    
    Version.where(:product_id => product_id)
      .where(["sort_order BETWEEN ? AND ifnull(?,999999999)", first, last])
  end

  def self.find_by_product_id_and_lowercase_name(product_id, name)
    where(:product_id => product_id).where(["lower(name) = ?", name]).first
  end

end
