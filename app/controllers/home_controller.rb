class HomeController < ApplicationController
  skip_before_action :authentication!, only: %i(login)

  def login
  end
end
