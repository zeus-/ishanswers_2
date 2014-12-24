FactoryGirl.define do
  factory :answer do
    body Faker::Company.bs  
    association :question, factory: :question
    association :user, factory: :user
  end
end
