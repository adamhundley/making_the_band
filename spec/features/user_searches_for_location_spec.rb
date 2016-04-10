require 'rails_helper'

describe "user searches for a location" do
  it "returns a collection of shows for that location" do
    VCR.use_cassette "location#new" do
      visit "/"
      fill_in "City, State", with: "Denver, CO"
      click_on "FIND BY LOCATION"

      expect(current_path).to eq locations_path
      expect(page).to have_content("Denver, CO")

      fill_in "location", with: "Wheeling, WV"
      fill_in "checkin", with: "2016-04-07"
      fill_in "checkout", with: "2016-04-09"
      click_on "Search"

      expect(current_path).to eq locations_path
      expect(page).to have_content("Wheeling, WV")
    end
  end
end
