class BitService
  def initialize
    @_connection = Faraday.new(url: "http://api.bandsintown.com")
    connection.params['app_id'] = "making_the_band"
  end

  def location(params)
    parse(connection.get("/events/search.json?", params))
  end

  def artist(name)
    name = name.split.join('%20')
    parse(connection.get("/artists/#{name}/events.json?api_version=2.0"))
  end

private

  def connection
    @_connection
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
