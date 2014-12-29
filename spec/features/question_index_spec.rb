require 'spec_helper'
feature "Question Index Page" do
  it "should list Q's in the db" do
    question = create(:question)
    visit questions_path # or root_path atm
    expect(page).to have_text /#{question.title}/i
  end
end
