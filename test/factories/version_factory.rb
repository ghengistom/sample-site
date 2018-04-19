FactoryGirl.define do
  factory :version do
    name
    association :product
    sequence(:sort_order) { |n| n }
    status "active"
  end
end