FactoryGirl.define do
  factory :user do
  	first_name Faker::Name.first_name
  	last_name Faker::Name.last_name
    sequence(:email) {|n| "some_email#{n}@awesomeanswers.com" }
    # password Faker::Internet.password
  	password "foodbars"
  	password_confirmation "foodbars"
  end
end