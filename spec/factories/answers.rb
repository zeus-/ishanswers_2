FactoryGirl.define do
  factory :answer do
    association :question, factory: :question
    body Faker::Company.bs    
  end
end
