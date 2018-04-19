class Example < ActiveRecord::Base
  belongs_to :category
  belongs_to :cloned, :class_name => "Example", :foreign_key => "clone_id"
  has_and_belongs_to_many :attachments
  has_many :example_versions, :dependent => :destroy
  has_many :products, :through => :example_versions
  
  before_save :update_status_from_parent
  before_save :flush_cache
  after_save :update_clones
  
  acts_as_taggable_on :tags
  
  cattr_reader :per_page
  @@per_page = 10
  
  validates_presence_of :title, :example_type, :example_versions, :category
  validates_presence_of :code, :if => "clone_id.nil?"
  validate :example_type_must_be_one_of_two
  
  validate :example_title_must_not_conflict
  validate :example_title_must_not_contain_period
  
  # validates_uniqueness_of :title, :scope => "products.id"
  # validates_associated :example_versions
  
  [:vb, :cs, :vbs, :asp, :php, :cfm, :rb, :ps1].each do |lang|
    default_value_for lang, true
  end
  
  scope :is_method, -> { where(:example_type => "basic", :is_method => true) }
  scope :is_property, -> { where(:example_type => "basic", :is_method => false) }
  scope :is_advanced, -> { where(:example_type => "advanced") }
  scope :is_not_advanced, -> { where(:example_type => "basic") }
  scope :is_original, -> { where(:clone_id => nil) }
  
  scope :is_active, -> { where(:status => "active") }
  scope :is_qa, -> { where("examples.status = ? OR examples.status = ?", "active", "qa") }
  
  include MultipleProducts
  
  def example_title_must_not_conflict
    products = []
    example_versions.each do |ev|
      Version.find_by_product_id_between_version_ids(ev.product_id, ev.version_id_start, ev.version_id_end).each do |v|
        Example.find_all_by_product_id_and_version_sort_order(ev.product_id, v.sort_order).each do |e|
          errors.add(:title, "can't match another example in the same product and version range") if e.title.downcase == title.downcase && e.id != id
        end
      end
    end
  end
  
  def example_title_must_not_contain_period
    errors.add(:title, "can't contain a period (.)") if self.title.include? '.'
  end
  
  def example_type_must_be_one_of_two
    errors.add(:example_type, "must be either basic or advanced") unless %w(basic advanced).include?(example_type)
  end
  
  def self.find_all_by_product_id_and_version_sort_order(product_id, sort_order)
    examples = Example.where(["products.id = ?", product_id])
      .joins(:example_versions)
      .joins(:products)
      .joins("LEFT JOIN versions vs ON example_versions.version_id_start = vs.id")
      .joins("LEFT JOIN versions ve ON example_versions.version_id_end = ve.id")
      .where(["? BETWEEN vs.sort_order AND ifnull(ve.sort_order,999999999)", sort_order])
      .where(["example_versions.product_id = ?",product_id])
      .order("examples.title ASC")
    #examples = examples.is_active unless Admin.current
    
    return examples
  end

  def self.find_by_product_id_and_version_and_title(product_id, version, title)
    Example.find_all_by_product_id_and_version_sort_order(product_id, version.sort_order).where("LOWER(title) == ?", title.downcase).first
  end

  def code
    if clone_id.nil?
      return self[:code]
    else
      return parent_clone.code
    end
  end
  
  def parent_clone
    if clone_id.nil?
      return self
    else
      theparent = nil
      parent = cloned
      while parent.class == Example
        theparent = parent
        parent = parent.cloned
      end
      
      return theparent
    end
  end
  
  def cloned_attachments
    if clone_id.nil?
      Attachment.joins("JOIN attachments_examples ae ON ae.attachment_id = attachments.id").where(["ae.example_id = ?",id]).all
    else
      parent_clone.attachments
    end
  end
  
  def self.statuses
    {
      "Active" => "active",
      "In Progress" => "in progress",
      "Inactive" => "inactive",
      "QA" => "qa"
    }
  end
  
  def hits(options = Hash.new)
    options[:language] ||= nil
    options[:views] = true if options[:views].nil?
    
    if options[:language]
      search_string = if options[:views]
        "example-#{self.id}-#{options[:language]}"
      else
        "example-#{self.id}-#{options[:language]}-%"
      end
      Hit.where("content LIKE '#{search_string}'").count
    else
      Hit.where("content LIKE 'example-#{self.id}%'").count
    end
  end
  
  def languages
    output = Hash.new
    output['C#'] = "cs" if cs
    output["VB.NET"] = "vb" if vb
    output["VBS"] = "vbs" if vbs
    output["ASP"] = "asp" if asp
    output["PHP"] = "php" if php
    output["CF"] = "cfm" if cfm
    output["Ruby"] = "rb" if rb
    output["PS"] = "ps1" if ps1
    output["Shell"] = "shell" if shell
    output["HTML"] = "html" if html
    output
  end
  
  def self.all_languages
    {
      'C#'     => "cs",
      "VB.NET" => "vb",
      "VBS"    => "vbs",
      "ASP"    => "asp",
      "PHP"    => "php",
      "CF"     => "cfm",
      "Ruby"   => "rb",
      "PS"     => "ps1",
      "Shell"  => "shell",
      "HTML"   => "html"
    }
  end
  
  def self.full_language_name_by_shortname
    {
      "cs" => 'C#',
      "vb" => "VB.NET",
      "vbs" => "VBScript",
      "asp" => "ASP",
      "php" => "PHP",
      "cfm" => "ColdFusion",
      "rb" => "Ruby",
      "ps1" => "PowerShell",
      "shell"  => "Shell",
      "html"   => "HTML"
    }
  end
  
  def self.language_types
    {
      "cs" => :net,
      "vb" => :net,
      "vbs" => :com,
      "asp" => :com,
      "php" => :com,
      "cfm" => :net,
      "rb" => :com,
      "ps1" => :com,
      "shell" => :com,
      "html" => :com
    }
  end
  
  def list_type
    case example_type
    when "basic"
      is_method ? "method" : "property"
    when "advanced"
      "advanced"
    end
  end
  
  def update_clones
    self.clones.each do |clone|
      clone.status = status
      clone.save
    end
  end
  
  def update_status_from_parent
    unless clone_id.nil?
      # update from top most clone
      self.status = parent_clone.status
    end
  end
  
  def clones
    myclones = []
    thunk = lambda do |clone|
      # puts "Clone: #{clone.id} - #{clone.title} - #{clone.class}"
      myclones << clone
      children = Example.where(:clone_id => clone.id)
      children.each(&thunk)
    end
    
    Example.where(:clone_id => self.id).each(&thunk) unless self.id.nil?
    myclones
  end
  
  def flush_cache
    # Rails.cache.delete_matched("#{self.parent_clone.id}.*")
  end

  def example_title
    display_title? ? display_title : title.gsub("-", ".")
  end

  def video=(value)
    self[:video] = value.gsub('http://youtu.be/','').gsub('http://youtube.com/watch/?v=','')
  end
end
