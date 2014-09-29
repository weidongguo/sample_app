FactoryGirl.define do
  factory :user do  # passing the symbol :user to factory command, we tell Factory Girl that the subseqeuent definition is for a User model object.
    name  "Michael Hartl"
    email("michael@example.com")
    password("foobar1")
    password_confirmation "foobar1"
  end
end
