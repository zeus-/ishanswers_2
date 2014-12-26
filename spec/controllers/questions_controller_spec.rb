require 'rails_helper'
require 'spec_helper'

describe QuestionsController do
  let(:user) { create(:user) }

  describe "#index" do
    it "assigns the @questions var" do
      get :index
      expect(assigns(:questions)).to be
    end
    it "includes all q's in the db" do
      question = create(:question)
      get :index
      expect(assigns(:questions)).to include(question)
    end
    it "renders the index template" do
      get(:index)
      expect(response).to render_template(:index)
    end
    it "only fetches 10 questions" do
      20.times { create(:question) }
      get :index
      expect(assigns(:questions).length).to eq(10)
    end
  end
  describe "#new" do
    context "with a signed in user" do
      before { sign_in user } 
      it "creates a new Q in the db" do
        get :new
        expect(assigns(:question)).to be_a_new(Question)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
    context "with a signed out user" do
      it "redirects to sign in page" do
        get :new 
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "#create" do
      context "w/o a signed in user" do
        it "redirects to sign in page if hitting create" do
          post :create
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context "with a signed in user" do
        before { sign_in user } 
        context "with a valid request" do
          def valid_request 
            post :create, question: { title: "Hola", description: "sum words" }
          end
          it "creates a Q in the db" do
            expect { valid_request }.to change { Question.count }.by(1)
          end
          it "should redirect to the Q index" do
            valid_request
            expect(response).to redirect_to(questions_path)
          end
          it "sets a flash msg" do
            valid_request
            expect(flash[:notice]).to be 
          end
          it "assigns the question to the signed in user" do
            expect { valid_request }.to change { user.questions.count }.by(1)
          end
        end
        context "with an invalid request" do
          def invalid_request 
            post :create, question: { title: "Hola", description: "" }
          end
          it "doesnt create a Q in the db" do
            expect { invalid_request }.to_not change { Question.count }
          end
          it "should render the new question page" do
            invalid_request
            expect(response).to render_template(:new)
          end
        end
      end
    end
  end
  describe "#show" do
    let(:question) { create(:question) } 
    context "w/o a signed in user" do
      it "assigns the question variable to that of the question id that's passed" do
        get :show, id: question.id
        expect(assigns(:question)).to eq question
      end
    end
  end
  describe "#update" do
    context "with a signed in user" do
      before { sign_in user } 
      let(:question) { create(:question, user: user) }
      it "updates the appropriate question with the id that is passed" do
        patch :update, id: question.id, question: { title: "New title" }
        question.reload
        expect(question.title).to match /New title/i
      end
      it "redirects to the question show page after a successful update" do
        patch :update, id: question.id, question: { title: "New title" }
        expect(response).to redirect_to(question)
      end
      it "sets a flash msg after successful update" do
        patch :update, id: question.id, question: { title: "New title" }
        expect(flash[:notice]).to be
      end
      it "renders the edit template after a failed update" do
        patch :update, id: question.id, question: { title: "" }
        expect(response).to render_template(:edit)
      end
      it "raises an error if trying to update another user's q" do
        expect do
          patch :update, id: question.id2, question: { title: "Valid new title" } 
        end.to raise_error
      end
    end
  end

  describe "#destroy" do
    let!(:question) { create(:question, user: user) } 
    context "with a signed in user" do
      before { sign_in user } 
      it "should destroy the appropriate Q from the db " do
        expect do
          delete :destroy, id: question.id 
        end.to change { Question.count }.by(-1)
      end
      it "should redirect to the questions index after a successful delete" do
        delete :destroy, id: question.id
        expect(response).to redirect_to(questions_path)
      end
      it "raises an error when trying to delete another user's Q" do
        expect { delete :destroy, id: question1.id }.to raise_error
      end
    end
  end

end
