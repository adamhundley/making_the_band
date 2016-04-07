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
              :url,
              :city,
              :region

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
    if !params[:start].nil?
      date_params(params)
    end
    show_data = service.shows(params)
    shows = build_objects(show_data)
    shows.geo_info = get_geo_info(shows)
    shows
  end

  def self.build_objects(shows)
    shows.map do |show|
      Show.new(show)
    end
  end

  def self.service
    BitService.new
  end

private

  def self.date_params(params)
    params[:date] = params[:start],params[:end]
    params[:date] = params[:date].join(",")
  end

  def self.get_geo_info(shows)
    shows.map do |show|
      [show.venue_latitude, show.venue_longitude]
    end
  end
end
