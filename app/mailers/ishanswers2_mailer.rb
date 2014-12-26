class Ishanswers2Mailer < ActionMailer::Base
  default from: "info@ishanswers2.herokuapp.com"
  def notify_question_owner(answer)
    @answer = answer
    @question = @answer.question
    @receiver = @question.user
    mail(to: @receiver.email, subject: "You've got a new answer to your question!") 
  end
  
end
