class Artist
  attr_reader :shows

  def self.service
    ArtistFinder.new
  end

  def self.find(name)
    artist_data = service.artist(name)
    build_object(artist_data)
  end

  def self.shows(name)
    artist_data = service.shows(name)
    build_objects(artist_data)
  end

  private

    def self.build_objects(data)
      data.map do |d|
        Show.build_object(d)
      end
    end

    def self.build_object(data)
      OpenStruct.new(data)
    end
end
