class UsersController < ApplicationController
  def new
    @user = User.new 
  end
  
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user= User.new(user_params) 
    if @user.save
      sign_in @user 
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id]) # i think id is passed to params from path_name
                                   # e.g. users/1/edit for PATCH (edit)
                                   # e.g. users/1 for GET (show)
  end
 
  def update
    @user = User.find(params[:id]) 
    if( @user.update_attributes(user_params)  )
      flash[:success] = "Profile updated"
      redirect_to user_path(@user) # redirect_to goes to the action first
                                   # basically doing a full request
    else # errors occured 
      render 'edit' # directly going to the view of edit, bypassing the controller
                    # so edit.html.erb has the @user from the update action
                    # not from the edit action. Thus, render doesn't do a request

    end                                 
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # returns a user hash with attribute :name, :email, :password, and pw_confir 
      # from params[user], but only allow those permitted attributes to be passed
      # require() ensures the existence of user hash in params(a hash of hashes)
    end
end


