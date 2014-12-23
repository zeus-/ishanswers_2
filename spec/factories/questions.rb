FactoryGirl.define do
  factory :question do
    title Faker::Company.bs
    description Faker::Lorem.sentence
  end
end
