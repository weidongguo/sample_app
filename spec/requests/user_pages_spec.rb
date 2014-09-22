require 'spec_helper'

describe "User Pages" do
  subject{ page } # b/c of this, {should} automtically uses the page variable supplied byCapybara.

  describe "signup page" do
    before {visit signup_path}
    it{ should have_content "Sign Up" }
    it{ should have_title full_title("Sign Up") }
  end

  describe "profile page" do
    # user = User.create(name: "Zhimin Hu", email:"zhimin@gmailc.om.com",
    #  password: "foobar", password_confirmation: "foobar")
    
    # Using FactoryGirl is more convienient than using User.create
    # for instance, if there is any error(email already existed in db) in
    # saving the record into the
    # database, ActiveRecord won't hint me in the Rspec test,
    # it will just tell me that it can't visit User controller and the action
    # However, FactoryGirl.create will hints me
    let(:user) { FactoryGirl.create(:user) }
    
    before { visit user_path(user) }
    
    it{ should have_content(user.name) }
    it{ should have_title(user.name) }
    end
end
