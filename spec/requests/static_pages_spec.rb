require 'spec_helper'

base_title = "Ruby on Rails Tutorial Sample App"

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to(have_content('Sample App'))
    end
    it "should have title 'Home'" do
      visit '/static_pages/home'
      expect(page).to(have_title(base_title))
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to(have_content('Help'))
    end
    
    it "should have the title 'Ruby on Rails Tutorial Sample App | Help'" do
      visit '/static_pages/help'
      expect(page).to(have_title("#{base_title} | Help"))
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to(have_content("About Us"))
    end
    it "should have the title 'Ruby on Rail Tutorial Sample App | About Us" do
      visit '/static_pages/about'
      expect(page).to(have_title("#{base_title} | About Us"))
    end
  end
end

