require 'spec_helper'

describe User do
  before { @user= User.new(name: "Example User", email: "user@example.com") }
  subject { @user}
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should be_valid }   # whenever there is a boolean method valid?, there is
                           # a corresponding be_valid test method in Rspec.
                           # In general, foo? -> be_foo 

  describe "when name is not present" do
    before { @user.name=" " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email=" " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a"*51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
        foo@baz_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses= %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_addr|
        @user.email = valid_addr
        should be_valid 
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup #dup() creates a duplicate object with all attributes the same except created_at, updated_at, and id all = nil.
      user_with_same_email.email=@user.email.upcase
      user_with_same_email.save
    end
      it {should_not be_valid}
  end
end
