class SessionsController < ApplicationController
  def create
    session[:user_id] = UserFromOmniauth.call(request.env["omniauth.auth"]).id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
