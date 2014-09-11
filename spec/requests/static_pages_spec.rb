require 'spec_helper'

base_title = "Ruby on Rails Tutorial Sample App"

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/' 
      expect(page).to(have_content('Sample App'))
    end
    it "should have title base title" do
      visit root_path 
      expect(page).to(have_title(base_title))
    end
    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to(have_title('| Home'))
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path 
      expect(page).to(have_content('Help'))
    end
    
    it "should have the title 'Ruby on Rails Tutorial Sample App | Help'" do
      visit help_path #hard-coded address: help_path = "/static_pagea/about"
      expect(page).to(have_title("#{base_title} | Help"))
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit about_path 
      expect(page).to(have_content("About Us"))
    end
    it "should have the title 'Ruby on Rail Tutorial Sample App | About Us" do
      visit about_path 
      expect(page).to(have_title("#{base_title} | About Us"))
    end
  end
  
  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit contact_path 
      expect(page).to(have_content('Contact'))
    end
    
    it "should have the title 'title'" do
      visit contact_path 
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end

