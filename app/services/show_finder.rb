class ShowFinder
  attr_reader :host, :tail

  def initialize
    @host = "http://api.bandsintown.com/events/search.json?location="
    @tail = "&radius=20&app_id=making_the_band"
  end

  def shows(location)
    location = location.split.join('%20')
    parse(get("#{location}"))
  end

  def get(location)
    prepared_path = prepare_path(location)
    Faraday.get(prepared_path)
  end

  def prepare_path(location)
    host + location + tail
  end

private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
