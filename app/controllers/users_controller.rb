class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    debugger
    if @user.save

      render login
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :bitcoin_address)
  end

  def login
    debugger
    User user = User.find_by_email(params[:user][:email])
    
    if user.valid_password?(params[:user][:password])
    end
  end
end