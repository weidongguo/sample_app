require 'spec_helper'

describe User do
  before { @user= User.new(name: "Example User", email: "user@example.com",
            password:"foobar", password_confirmation: "foobar") }
  subject { @user}
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should be_valid }   # whenever there is a boolean method valid?, there is
                           # a corresponding be_valid test method in Rspec.
                           # In general, foo? -> be_foo 
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

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
        foo@baz_baz.com foo@bar+baz.com foo@bar..com]
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

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", 
        password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before {
      @user.password_confirmation = "mismatch"
    }
    it { should_not be_valid }  
  end

  describe "return value of authenticate method" do
    before {@user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    # let() create a local variable with the name of it's arg, which a symbol
    # So, the local var is named found_user.
    # then the found_user = the return value from the block
    # This local var can be used in any of the before and it blocks through
    # the rest of the test
    # Finally, let() memoize it's value too. that find_by(...) is called only
    # once, if the same call happens again, no need to implement the call, the
    # desired value can be retrieved right off from the cache
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
         # if authenticate succeeded(PW match), an object of User is returned
         # which should be the same instance of the subject, @user.
         # if authentication failed, authenticate return false, which won't
         # match with the object ==> @user (an obj) != false (a boolean value)
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password){ found_user.authenticate("invalid") }
      # in this case, the authenticate returns false

      it { should_not eq user_for_invalid_password }
      # @user is not boolean value false

      specify { expect(user_for_invalid_password).to be_false }
      # specify method is the same as the it method, be it sound better in
      # in this context
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "email addr with mixed cases" do
    let(:mixed_case_email) { "Foo@ExAmPle.CoM"}
    
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
     end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank}
    # equivalent to> it { expect(@user.remember_token).not_to be_blank } 
  end
end
