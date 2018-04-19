class Hit < ActiveRecord::Base
  validates_presence_of :content
  
  # content styles:
  # example-id-lang
  # example-id-lang-download
  # example-id-lang-copy
end
