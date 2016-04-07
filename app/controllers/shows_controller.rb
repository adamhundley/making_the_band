class ShowsController < ApplicationController

  def index
    @location = Location.find_by(show_params)
    # @shows = Show.find_by(show_params)
  end

private

  def show_params
    params[:show]
  end
end
