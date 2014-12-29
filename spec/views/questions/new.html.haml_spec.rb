require 'spec_helper'
require 'rails_helper'

describe "questions/new.html.haml" do
  before do
    assign(:question, stub_model(Question) ) 
    render
  end
  it "contais the text 'New Question page'" do
    expect(rendered).to match /New Question page/i
  end
  it "renders the '_form' tempalate" do
    expect(rendered).to render_template(partial: '_form')
  end
end
