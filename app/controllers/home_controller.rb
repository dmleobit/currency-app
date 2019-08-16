class HomeController < ApplicationController
  def login
  end

  def api_data
    data = GetApiData.new.data


    render json: { wow: data }
  end
end
