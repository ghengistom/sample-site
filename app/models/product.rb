class Product < ActiveRecord::Base
  has_many :example_versions, :dependent => :destroy
  has_many :examples, :through => :example_versions
  has_many :versions, :dependent => :destroy
  has_many :snippet_versions, :dependent => :destroy
  has_many :snippets, :through => :snippet_versions
  
  scope :active, -> { joins(:versions).where("versions.status" => "active").order(:name).uniq }
  scope :legacy, -> { joins(:versions).where("versions.status" => "legacy").order(:name).uniq }
  scope :future, -> { joins(:versions).where("versions.status" => "future").order(:name).uniq }
  scope :active_or_future, -> { joins(:versions).where("versions.status = 'active' OR versions.status = 'future'").order(:name).uniq }
  scope :with_snippets, -> { joins(:snippets).uniq }
  
  validates_presence_of :name
  
  def latest_version
    versions.where('status = ? or status = ?', 'active', 'legacy').order("sort_order ASC").last
  end

  def latest_version_from_all
    versions.where('status = ? or status = ? or status = ?', 'active', 'legacy', 'future').order("sort_order ASC").last
  end

  def self.find_by_lowercase_name(name)
    where(["lower(name) = ?", name]).first
  end
end
