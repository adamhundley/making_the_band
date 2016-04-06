class Artist
  attr_reader :name, :image_url, :thumb_url, :website, :facebook_url, :facebook_tour_url
  attr_accessor :shows

  def initialize(artist)
    @name = artist[:name]
    @image_url = artist[:image_url]
    @thumb_url = artist[:thumb_url]
    @website = artist[:website]
    @facebook_url = artist[:facebook_page_url]
    @facebook_tour_url = artist[:facebook_tour_dates_url]
    @shows = []
  end

  def self.service
    BitService.new
  end

  def self.find_by(name)
    shows = service.artist(name)
    artist = build_artist_object(shows.first[:artists].first)
    artist.shows = build_show_objects(shows)
    artist
  end

  private

    def self.build_artist_object(artist)
      Artist.new(artist)
    end

    def self.build_show_objects(shows)
      shows.map do |show|
        Show.new(show)
      end
    end

end
