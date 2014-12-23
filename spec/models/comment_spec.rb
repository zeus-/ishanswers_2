require 'rails_helper'

describe Comment do
  
  it "doesnt allow creating a cmnt w/o a body" do
    cmnt = Comment.new
    expect(cmnt).to_not be_valid
  end
  
  it "invalid cmnt shows the appropriate error" do
    cmnt = Comment.new
    expect(cmnt).to_not be_valid
    cmnt.save
    cmnt.errors.messages.should have_key(:body)
  end

  it "doesnt create a cmnt body shorter than 3 chars" do
    cmnt = Comment.create(body: "aa")
    expect(cmnt).to_not be_valid
  end

  describe ".sanitize" do
    it "should remove extra white spaces in cmnt body" do
      text = "Hello        world!"
      cmnt = Comment.new(body: text)
      cmnt.sanitize
      expect(cmnt.body).to eq("Hello world!")
    end
    it "should remove extra spaces on the edges of the smnt body" do
      text = "  Hello   world!  "
      cmnt = Comment.new(body: text)
      cmnt.sanitize
      expect(cmnt.body).to eq("Hello world!")
    end
  end
  describe "Recent ten cmnt scope" do
    before do
      11.times { |x| Comment.create(body: "Valid body #{x}") } 
    end
    it "returns only 10 cmnts" do
      expect(Comment.recent_ten.count).to eq(10)
    end
    it "returns only recent comments" do
      expect(Comment.recent_ten).to_not include(Comment.first)
    end
  end

end
