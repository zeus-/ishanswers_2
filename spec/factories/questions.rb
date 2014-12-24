FactoryGirl.define do
  factory :question do
    sequence(:title) { |number| "#{Faker::Company.bs} #{number}" }
    description Faker::Lorem.sentence
  end
end