require 'rails_helper'

describe Artist do
  context(".find_by") do
    it "returns a collection of shows" do
      VCR.use_cassette "artist#find_by" do
        artist = Artist.find_by("Mutemath")
        show = artist.shows.first

        expect(artist.class).to eq Artist
        expect(show.class).to eq Show
      end
    end
  end
end
