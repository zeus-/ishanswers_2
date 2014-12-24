require 'rails_helper'

describe CommentsController do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  let(:user) { create(:user) }
  def valid_request
    post :create, answer_id: answer.id, comment: { body: "valid body" } 
  end
  def invalid_request
    post :create, answer_id: answer.id, comment: { body: "" }
  end
  describe "#create" do
    context "w/o a signed in user" do
      it "doesnt create a cmnt in db" do
        expect { valid_request }.to_not change { Comment.count }
      end
      it "redirects to new user seesion path" do
        valid_request
        expect(response).to redirect_to(new_user_session_path)
      end
    end
     context "with a signed in user" do
      before { sign_in user }
      context "with valid request" do
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
    context "with an invalid request" do
      it "doesnt create a cmnt in db with invalid request" do
        expect { invalid_request }.to_not change { Comment.count }
      end
      it "renders the the question show page" do
        invalid_request
        expect(response).to render_template(:show)
      end
      it "sets a flash alert" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end
end
  describe "#destroy" do
    let!(:comment) { create(:comment, answer: answer) }
    def delete_request
      delete :destroy, id: comment.id, answer_id: answer.id 
    end
    context "w/o signed in user" do
      it "should redirect to the new user path" do
        delete_request
        response.should redirect_to(new_user_session_path)
      end
     end
    context "w a signed in user" do
      before { sign_in user } 
      it "should delete cmnt from db" do
        expect { delete_request }.to change { Comment.count }.by(-1)
      end
      it "should redirect to Q show page" do
        delete_request
        response.should redirect_to(answer.question)
      end
      it "should set a flash notice msg upon deletion" do
        delete_request
        expect(flash[:notice]).to be
      end
    end
  end
end

