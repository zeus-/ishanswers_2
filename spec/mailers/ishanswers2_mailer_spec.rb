require "rails_helper"
require "spec_helper"
describe Ishanswers2Mailer do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user1) }
  describe "#notify question owner" do
    #before do 
     # @mail = Ishanswers2Mailer.notify_question_owner(answer) 
    #end
    #refactored using subject, its and should!
    subject { Ishanswers2Mailer.notify_question_owner(answer) }
    its(:to) { should eq ([user.email]) }
    its(:from) { should eq (["info@ishanswers2.herokuapp.com"]) }
    its("body.to_s" ) { should match /#{@answer.body}/i }
    #it "sends an email to question owner" do
     # expect(@mail.to).to eq ([user.email])
    #end
    #it "sends an email from info@ishanswers2.com" do
     # expect(@mail.from).to eq (["info@ishanswers2.herokuapp.com"])
    #end
    #it "contains the answer body in the email body" do
     # puts ">>>>>>>>>>>>>>>>>#{@mail.body.class}"
      # expect(@mail.body.to_s).to match /#{answer.body}/i
    #end
  end
end
