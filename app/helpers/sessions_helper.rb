module SessionsHelper

  # Logs in the given user, setting the session[:user_id].
  def log_in(user)
    session[:user_id] = user.id
  end

    # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

    # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

    # Logs out, the user setting session[:user_id] to nil.
  def logout(user)
    session[:user_id] = nil
    redirect_to root_path
  end
end