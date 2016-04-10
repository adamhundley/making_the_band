class ArtistsController < ApplicationController
  def index
    @artist = Artist.find_by(artist_params)
    session[:artist] = artist_params
    if @artist.class == String
      flash[:alert] = "#{@artist}"
      redirect_to request.referer
    end
  end

private

  def artist_params
    params[:artist][:artist]
  end
end
