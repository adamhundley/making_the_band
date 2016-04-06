class ShowsController < ApplicationController

  def index
    @shows = Show.find_by(show_params)
  end

private

  def show_params
    params[:show]
  end
end
