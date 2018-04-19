FactoryGirl.define do
  sequence :name do |n|
    "Name-#{n}"
  end
  
  factory :snippet do
    name
    code "comment 'this is a comment from a snippet'"
    before(:create) do |snippet|
      category = Category.first || FactoryGirl.create(:category)
      snippet.category = category
    end
  end
end