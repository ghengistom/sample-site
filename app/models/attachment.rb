class Attachment < ActiveRecord::Base
  has_and_belongs_to_many :examples
  has_and_belongs_to_many :snippets
  has_attached_file :file

  do_not_validate_attachment_file_type :file
  
  validates_uniqueness_of :file_file_name
  validates_attachment_presence :file
end
