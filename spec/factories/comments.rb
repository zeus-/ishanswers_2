FactoryGirl.define do
  factory :comment do
   #  association :user, factory: :user
    association :answer, factory: :answer
    body Faker::Lorem.sentence
  end
end
