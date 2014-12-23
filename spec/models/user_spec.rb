require 'rails_helper'

describe User do
  describe ".full_name" do
    it "should return first name or last name, if they exist" do
      user = User.new(first_name: "Ish", last_name: "Hera", email: "x@x.com")
      expect(user.full_name).to eq("Ish Hera")
    end
    it "should return the email if no names are provided" do
      user = User.new(email: "x@x.com")
      expect(user.full_name).to eq("x@x.com")
    end
  end
end
