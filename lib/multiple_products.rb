module MultipleProducts
  def potential_products
    current_products = products.collect{|p| p.id}
    Product.where("id NOT IN (#{current_products.join(",")})")
  end
  
  def versions=(version_attributes_json)
    local_versions = send "#{self.class.to_s.downcase}_versions"
    local_versions.clear unless new_record?
    version_attributes = JSON.parse(version_attributes_json)
    version_attributes.each do |attributes|
      local_versions.build(attributes)
    end
  end
end
