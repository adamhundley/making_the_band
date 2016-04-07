class Location
  attr_reader :location
  attr_accessor :shows, :geo_info, :shows_geo_info, :titles

  def initialize(location)
    @location = location
    @shows = []
    @shows_geo_info = []
    @geo_info = []
    @titles = []
  end

  def self.find_by(params)
    if !params[:start].nil?
      date_params(params)
    end
    params[:per_page] = 100
    location_data = service.location(params)

    if location_data.class != Array
      "#{params[:location].upcase} is not a real place! Try again!"
    else
      location = build_location_object(params[:location])
      location.shows = build_show_objects(location_data)
      location.shows_geo_info = get_geo_info(location.shows)
      location.geo_info = set_geo_location(params[:location])
      location.titles = find_titles(location.shows)
      location
    end
  end

  def self.service
    BitService.new
  end

  def self.set_geo_location(location)
    Geocoder.search(location).first.data["geometry"]["location"]
  end

private

  def self.date_params(params)
    params[:date] = params[:start],params[:end]
    params[:date] = params[:date].join(",")
  end

  def self.build_location_object(location)
    Location.new(location)
  end

  def self.build_show_objects(shows)
    shows.map do |show|
      Show.new(show)
    end
  end

  def self.get_geo_info(shows)
    shows.map do |show|
      [show.venue_latitude, show.venue_longitude]
    end
  end

  def self.find_titles(shows)
    shows.map do |show|
      show.artist
    end
  end

end
