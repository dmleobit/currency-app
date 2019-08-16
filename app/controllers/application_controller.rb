class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authentication!
    if current_user.blank?
      redirect_to home_login_path
    else
      # $redis.expire(current_session, 1.week)
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
