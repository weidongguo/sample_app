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
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # returns a user hash with attribute :name, :email, :password, and pw_confir 
      # from params[user], but only allow those permitted attributes to be passed
      # require() ensures the existence of user hash in params(a hash of hashes)
    end
end


