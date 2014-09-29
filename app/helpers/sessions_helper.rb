module SessionsHelper
  
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token 
    # the special permanent method set the expiration to 20.years.from_now
    # cookies[:remember_token][value] = remember_token
    # cookies[:remember_token][expires] = 20.years.from_now

    # i guess permanent returns an object(type hash) with the
    # default expires = 20.years.from_now 

    user.update_attribute(:remember_token, User.digest(remember_token) )
    #user.update_attribute() bypasses validation, unlike user[:remember_token] = ...
    
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

end
