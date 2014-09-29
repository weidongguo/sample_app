class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if( user && user.authenticate(params[:session][:password]) )
      sign_in user 
      redirect_to user 
    else
      flash.now[:error] = "Invalid email/password combination" #not quite right!
      render 'new' # render doesn't count as a request, so the flash message persists one more request than we want

    end
  end

  def destroy

  end



end
