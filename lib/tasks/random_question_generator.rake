namespace :my_generator do
  desc "Generate 10 Q's with 10 A's each"
  task :question_and_answers => :environment do
    10.times do
      question = Question.create(title: Faker::Lorem.sentence(10), description: Faker::Lorem.sentence(30))
      10.times do
        question.answers.create(body: Faker::Company.bs)
      end
    end
  end

end
