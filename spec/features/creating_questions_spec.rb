require 'spec_helper'
feature "Creating a Question" do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  before do
    login_as(user, scope: :user)
  end
  it "creates a Q in the db" do
    visit questions_path
    click_on "Create a new Q"
    fill_in "Title", with: "Valid Tit"
    fill_in "Description", with: "I am a description" 
    click_on "Save"
    expect(current_path).to eq questions_path
    expect(page).to have_text /Valid Tit/i
    # save_and_open_page
  end
  it "doesn't save a q with an empty title" do
    visit new_question_path
    fill_in "Title", with: ""
    fill_in "Description", with: "Valid description"
    click_on "Save"
    expect(page).to have_text /Please correct the form/i
    expect(Question.count).to eq(0)
  end
end
