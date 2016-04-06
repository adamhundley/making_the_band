class Show
  attr_reader :formatted_datetime,
              :title,
              :ticket_url,
              :facebook_rsvp_url,
              :artist,
              :artist_url,
              :venue_name,
              :venue_url,
              :formatted_location,
              :venue_latitude,
              :venue_longitude,
              :datetime,
              :url, :city, :region

  def initialize(show)
    @datetime = show[:datetime]
    @formatted_datetime = show[:formatted_datetime]
    @title = show[:title]
    @ticket_url = show[:ticket_url]
    @url = show[:url]
    @city = show[:venue][:city]
    @region = show[:venue][:region]
    @facebook_rsvp_url = show[:facebook_rsvp_url]
    @artist = show[:artists].first[:name]
    @artist_url = show[:artists].first[:url]
    @venue_name = show[:venue][:name]
    @venue_url = show[:venue][:url]
    @formatted_location = show[:formatted_location]
    @venue_latitude = show[:venue][:latitude]
    @venue_longitude = show[:venue][:longitude]
  end

  def self.find_by(params)
    shows = service.shows(params)
    build_objects(shows)
  end

  def self.build_objects(shows)
    shows.map do |show|
      Show.new(show)
    end
  end

  def self.service
    BitService.new
  end

end
