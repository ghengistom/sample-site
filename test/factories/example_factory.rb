FactoryGirl.define do
  sequence :title do |n|
    "Title-#{n}"
  end
  
  factory :example do
    title
    example_type "basic"
    code "comment 'this is an example'"
    before(:create) do |example|
      version = FactoryGirl.create(:version)
      example.example_versions << ExampleVersion.new(product: version.product, version_id_start: version.id)
      category = Category.first || FactoryGirl.create(:category)
      example.category = category
    end
  end
  
end