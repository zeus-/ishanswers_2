FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |x| "email#{x}@x.com" }  
    password "foodbars"
    password_confirmation "foodbars"
  end
end
