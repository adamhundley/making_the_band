class ShowsController < ApplicationController

  def index
    @shows = Show.find(location_params)
  end

private

  def location_params
    params[:location][:name]
  end
end
