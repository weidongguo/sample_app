require 'spec_helper'
#require '../../app/helpers/application_helper'
#full_title is a method from spec/support/utilities.rb


base_title = "Ruby on Rails Tutorial Sample App"

describe "Static pages" do
  subject{page}
  describe "Home page" do
    before{ visit root_path } # before method can also be invoked by before(:each) 
    
    it{ should(have_content('Sample App')) }
    it{ should(have_title(base_title)) } 
    it{ should_not(have_title(' | Home')) }

  end

  describe "Help page" do
    before{ visit help_path } 
    it{ should(have_content('Help')) }
    it{ should(have_title(full_title('Help'))) }
  end

  describe "About page" do
     before{ visit about_path } 
     it{ should have_content "About" }
     it{ should have_title full_title 'About' }
  end
  
  describe "Contact page" do
    before { visit contact_path }
    it{ should have_content "Contact" }
    it{ should have_title full_title 'Contact' }
  end
end

