class User < ActiveRecord::Base
  before_save { self.email = email.downcase}

  validates(:name, presence: true, length: { maximum: 50 } )
  
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # note: \-. is equivalent to \-\. representing char '-' and '.' and not the special metachararcter .   same thing as [\w+] means [\w\+] but \w+ means [\w]+

  validates(:email, presence: true, format: { with:VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false } )
  
    
end
