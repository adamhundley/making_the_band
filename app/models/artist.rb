class Artist
  attr_reader :name, :image_url, :thumb_url, :website, :facebook_url, :facebook_tour_url

  attr_accessor :shows, :geo_info

  def initialize(artist)
    @name = artist[:name]
    @image_url = artist[:image_url]
    @thumb_url = artist[:thumb_url]
    @website = artist[:website]
    @facebook_url = artist[:facebook_page_url]
    @facebook_tour_url = artist[:facebook_tour_dates_url]
    @shows = []
    @geo_info = []
  end

  def self.service
    BitService.new
  end

  def self.find_by(name)
    show_data = service.artist(name)
    artist = build_artist_object(show_data.first[:artists].first)
    artist.shows = build_show_objects(show_data)
    artist.geo_info = get_geo_info(artist.shows)
    artist
  end

  private

    def self.get_geo_info(shows)
      shows.map do |show|
        [show.venue_latitude, show.venue_longitude]
      end
    end

    def self.build_artist_object(artist)
      Artist.new(artist)
    end

    def self.build_show_objects(shows)
      shows.map do |show|
        Show.new(show)
      end
    end

end
