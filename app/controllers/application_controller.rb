class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authentication!
    redirect_to sessions_login_path if current_user.blank?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
