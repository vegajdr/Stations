module Locatable
  def Locatable.included other
    other.extend Locatable::ClassMethods
  end

  def distance_to other_lat, other_lon
    distance = Haversine.distance(self.latitude, self.longitude, other_lat, other_lon)
    distance.to_miles
  end

  module ClassMethods
    def closest_to lat, lon, options = nil
      main_location = [lat, lon]
      master = {}
      self.all.each do |station|
        master[station] = Haversine.distance(main_location,[station.latitude, station.longitude]).to_m
      end
      sorted = master.sort_by { |station, distance| distance }

      if options
        counted_list = sorted.shift(options[:count])
        results = counted_list.map do |s|
          s.first
        end
      else
        sorted[0].first
      end

    end
  end
end
