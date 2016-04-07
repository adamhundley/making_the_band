class LocationsController < ApplicationController

  def index
    @location = Location.find_by(location_params)
    if @location.class == String
      flash[:alert] = "#{@location}"
      redirect_to request.referer
    end
  end

private

  def location_params
    params[:show]
  end
end
