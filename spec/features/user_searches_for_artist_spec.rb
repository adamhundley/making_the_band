require 'rails_helper'

describe "user searches for an artist" do
  it "returns a collection of shows from that artist" do
    VCR.use_cassette "artist#update" do
      visit "/"
      fill_in "Artist Name", with: "Mutemath"
      click_on "FIND BY ARTIST"

      expect(current_path).to eq artists_path
      expect(page).to have_content("MUTEMATH")


      fill_in "artist", with: "John Mayer"
      click_on "Search"

      expect(current_path).to eq artists_path
      expect(page).to have_content("John Mayer")
    end
  end
end
