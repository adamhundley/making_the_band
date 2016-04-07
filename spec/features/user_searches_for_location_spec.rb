require 'rails_helper'

describe "user searches for a location" do
  it "returns a collection of shows for that location" do
    VCR.use_cassette "location#new" do
      visit "/"
      fill_in "City, State", with: "Denver, CO"
      click_on "FIND BY LOCATION"

      expect(current_path).to eq locations_path
      expect(page).to have_content("Denver, CO")
    end
  end
end
