FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| 
      n == 0 ? "Other" : "Category-#{n}" 
    }
  end
end