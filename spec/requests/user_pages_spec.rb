require 'spec_helper'

describe "User Pages" do
  subject{ page } # b/c of this, should automtically uses the page variable supplied byCapybara.

  describe "signup page" do
    before {visit signup_path}
    it{ should have_content "Sign Up" }
    it{ should have_title full_title("Sign Up") }
  end
end
