class User < ActiveRecord::Base
  
  # before_save { self.email = email.downcase}
  before_save { email.downcase! }
 
  before_create(:create_remember_token) #calls create_remember_token() before saving user 
  
  validates(:name, presence: true, length: { maximum: 50 } )
  
  #VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_EMAIL_REGEX =  /\A[\w.+-]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  # note: \-. is equivalent to \-\. representing char '-' and '.' and not the special metachararcter .   same thing as [\w+] means [\w\+] but \w+ means [\w]+

  validates(:email, presence:   true, 
                    format:     { with:VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false } )
  
  validates(:password, length: { minimum: 6 } )
  has_secure_password 
  # has_secure_password() does presence validation of password 
  # and it's confirmation validation 
  # and more
  # 1) added password and password_confirmation attribute to the User class
  # 2) require that they match
  # 3) add an authenticate method to compared a hashed password to the
  #    password_digest from the db.

  def User.new_remember_token
    SecureRandom::urlsafe_base64() 
  end
  
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s) # to_s() to take care of nil
  end

  private ######################### private methods #################

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end 
   
end

