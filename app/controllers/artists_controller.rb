class ArtistsController < ApplicationController
  def index
    @artist = Artist.find(artist_params)
    @shows = Artist.shows(artist_params)
  end

private

  def artist_params
    params[:artist][:name]
  end
end
