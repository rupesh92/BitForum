class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  def login
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save

      render 'login'
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :bitcoin_address)
  end

  def check_login
    debugger
    if User.find_by_email(params[:user][:email]).blank?
      debugger # may be exit and re render login page with a message invalid email
    else
      matched_user = User.find_by_email(params[:user][:email])
    end
    if matched_user.authenticate(params[:user][:password])
      debugger
    else
      # password id mismatch dude !
      debugger
    end
  end
end