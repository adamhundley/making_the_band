class ArtistFinder
  attr_reader :host, :tail

  def initialize
    @host = "http://api.bandsintown.com/artists/"
    @tail = ".json?api_version=2.0&app_id=making_the_band"
  end

  def artist(name)
    name = name.split.join('%20')
    parse(get("#{name}"))
  end

  def shows(name)
    name = name.split.join('%20')
    parse(get("#{name}/events"))
  end

  def get(name)
    prepared_path = prepare_path(name)
    Faraday.get(prepared_path)
  end

  def prepare_path(name)
    host + name + tail
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
