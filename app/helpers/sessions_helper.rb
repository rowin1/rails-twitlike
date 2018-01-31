module SessionsHelper

  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged-in user (if any)
  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find_by(id: session[:user_id])
      # @current_user ||= User.find_by(id: session[:user_id]) IDIOMATIC WAY IN RUBY
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if user is logged-in
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember # makes new token and stores the digest on db
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
