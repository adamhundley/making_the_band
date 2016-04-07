require 'rails_helper'

describe Location do
  context(".find_by") do
    it "returns a collection of shows" do
      VCR.use_cassette "location#find_by" do
        location = Location.find_by(location: "Denver, CO")
        show = location.shows.first

        expect(location.class).to eq Location
        expect(show.class).to eq Show
      end
    end
  end
end
