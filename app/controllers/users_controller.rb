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
    @user= User.new(params[:user]) # not the final implementation!
    if @user.save
      # handle a succesfful save
    else
      render 'new'
    end
  end

end
