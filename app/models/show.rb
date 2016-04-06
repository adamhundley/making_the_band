class Show < OpenStruct
    def self.service
      ShowFinder.new
    end

    def self.build_object(show_data)
      OpenStruct.new(show_data)
    end

    def self.find(location)
      location_data = service.shows(location)
      build_objects(location_data)
    end

    def self.build_objects(data)
      data.map do |d|
        Show.build_object(d)
      end
    end
end
