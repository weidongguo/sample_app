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

  describe "sign up" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
      
      describe "after submission" do
        before {click_button submit }
        it{ should have_title "Sign Up" }
        it{ should have_content "error" }

      end

    end
  
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create an user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user){User.find_by(email: "user@example.com")}
        
        it {should have_link('Sign out') }
        it {should have_title(user.name) }
        it {should have_selector('div.alert.alert-success', text: 'Welcome') }
      
        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end 
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }
    
    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title "Edit user" }
      it { should have_link('change', href: "http://gravatar.com/emails") } 
    end
     
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
  end 
end
