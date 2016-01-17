class SessionsController < ApplicationController

  # Redirects to login for a new session
  def new
  end

  # On login form submit , validates and logs the user in.
  # If the email_id and password are incorrect redirects to the login page with an error message.
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # Logs out the user.
  def destroy
    logout(User.find_by(id: session[:user_id]))
  end
end