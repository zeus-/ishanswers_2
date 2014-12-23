require 'rails_helper'

describe Answer do
  it "capitalizes answer body before saving to db" do
    answer = Answer.new(body: "hello world!")
    answer.save
    expect(answer.body).to eq("Hello world!")
  end
end
