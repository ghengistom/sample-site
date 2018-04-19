FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user-#{n}@domain.com" }
    password "asdfasdf"
    
  end
end