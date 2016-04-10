class ShowsController < ApplicationController

  def index
    @artist = Artist.find_by(params[:artist_artist_name])
    render json: @artist.shows
  end

end
