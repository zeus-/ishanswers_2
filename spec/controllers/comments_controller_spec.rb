require 'rails_helper'
require 'spec_helper' 
describe CommentsController do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  let(:user) { create(:user) }
  def valid_request
    post :create, answer_id: answer.id, comment: { body: "valid body" } 
  end
  describe "#create" do
    context "w/o a signed in user" do
      it "doesnt create a cmnt in db" do
        expect { valid_request }.to_not change { Comment.count }
      end
    end
    context "with a signed in user" do
      before { sign_in user }

    it "creates a cmnt in the db with valid params" do
      expect do
        valid_request
      end.to change { Comment.count }.by(1)
    end
    it "associates the cmnt with the answer" do
      expect { 
        valid_request
      }.to change { answer.comments.count }.by(1)
    end
    it "redirects to question after successful save to db" do
      valid_request
      expect(response).to redirect_to(answer.question)
    end
    end
  end

end
