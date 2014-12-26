require 'rails_helper'
require 'spec_helper'

describe AnswersController do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  context "with a signed in user" do
    before { sign_in user } 
    describe "#create" do
      def valid_request 
        post :create, question_id: question.id, answer: { body: "Is bootaylicious" } 
      end
      it "creates a new answer in the db" do
        expect { valid_request }.to change { question.answers.count }.by(1)
      end
      it "sends an email to the question owner" do
        ActionMailer::Base.deliveries.clear
        expect(ActionMailer::Base.deliveries).to have(1).item
      end
    end
  end
end

