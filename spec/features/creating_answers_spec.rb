require 'rails_helper'
require 'spec_helper'

feature "creating an answer for a q" do
  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  before do
    login_as(user, scope: :user)
  end

  it "creates the answer for the q", remote: true  do
    visit question_path(question.id)
    fill_in "answer_body", with: "a valid answer"
    click_on "Submit an answer"
    expect(page).to have_text /a valid answer/i
  end
end
