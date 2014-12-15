require "rails_helper"
require "spec_helper"
require './app/models/person.rb'

describe Person do
  describe "when no params are given" do 
    before(:each) do
      @person = Person.new
    end
  
  describe "#name" do
    it "should return 'unknown' if no params are given" do
      expect(@person.name).to eq ("unknown")
    end
    it "should be editable" do
      expect(@person.name = "John").to eq ("John")
    end
  end

  describe "#age" do
    it "should return 'unknown' if no params are give" do
      expect(@person.age).to eq ("unknown")
    end
    it "should be editable" do
      (@person.age = 12).should be 12
    end
  end
  
  describe "#job" do
    it "should return 'unknown' if no params are given" do
      expect(@person.job).to eq "unknown"
    end
    it "should be editable" do
      expect(@person.job = "gyno doctor").to eq ("gyno doctor")
    end
  end
  end  

  describe "with params given" do
    before(:each) do 
      @person = Person.new("Ish", 65, "Gyno doc") 
    end
    describe "#name" do
      it "should return Ish" do
        expect(@person.name).to eq "Ish"
      end
    end
    describe "#age" do 
      it "should be 65" do
        @person.age.should be 65
      end
    end
    describe "#job" do
      it "should be Gyno doc" do
      # deprecated, compares object ids instead of string values
        # @person.job.should be "Gyno doc"
      expect(@person.job).to eq "Gyno doc" 
      end
      it "should be editable" do
        expect(@person.job = "Gyno Specialist").to eq "Gyno Specialist"
      end
    end
  end
end
