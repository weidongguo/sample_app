module SessionsHelper
  
  # this method is specifially geared for the SessionsController class
  # it's secure b/c we generate a different token upon new sign-in

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
  
  # these are instance methods for all controllers #
  # Depending which controller u are using, the methods are instance methods of
  # that class since "include SessionsHelper" is added in ApplicationController.erb
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user # set the logging in user to be the current user
                         # we use a instance variable from an instance of 
                         # the Controller class
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    
    # ||= is useful only if current_user() is used more than once for a 
    # single user request.
    # @current_user is never nil unless the remember_token doesn't match
  end


  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token) )  # we can't simply assign nil to the remember token b/c hackers can 
       # take advantage of that and use a nil token to log in
    cookies.delete(:remember_token)
    self.current_user = nil # option step, in case not redirect_to a new page after
                            # signning out, then this.current_user is still there,
                            # making it still being signed in until a new page
                            # is directed to.
  end
end
