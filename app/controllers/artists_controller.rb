class ArtistsController < ApplicationController
  def index
    @artist = Artist.find_by(artist_params)
  end

private

  def artist_params
    params[:artist][:artist]
  end
end
