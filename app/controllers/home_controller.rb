class HomeController < ApplicationController
  def login
  end

  def api_data
    data = GetApiData.new.response


    render json: { wow: data }
  end
end
