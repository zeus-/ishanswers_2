require 'spec_helper'
require 'rails_helper'
feature "Visiting Home Page" do
  
  it "contains the text 'About Us' " do
    visit about_us_path # visit === capybara command 
    expect(page).to have_text /About Us/i # page is also a capybara cmnd 
  end

end
