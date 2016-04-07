require 'rails_helper'

describe BitService do
  context "#artist" do
    scenario "return a show" do
      VCR.use_cassette("bit_service#artist") do
        service = BitService.new
        artist = service.artist("Mutemath")
        show = artist.first
        expect(show[:artists].first[:name]).to eq "MUTEMATH"
      end
    end
  end
  context "#location" do
    scenario "return a show" do
      VCR.use_cassette("bit_service#location") do
        date_range = "#{Time.now.to_s.split[0]}, #{Time.now.to_s.split[0]}"
        service = BitService.new
        location = service.location(location: "Denver, CO", date: date_range)
        show = location.first
        expect(show[:venue][:city]).to eq "Denver"
        expect(show[:venue][:region]).to eq "CO"
        expect(show[:datetime].split("T")[0]).to eq Time.now.to_s.split[0]
      end
    end
  end
end
