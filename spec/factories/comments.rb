FactoryGirl.define do
  factory :comment do
    association :answer, factory: :answer
    body Faker::Lorem.sentence
  end
end