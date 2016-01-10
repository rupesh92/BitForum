class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to User.find_by_id(session[:user_id])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def login
      @user = User.new
  end
end
