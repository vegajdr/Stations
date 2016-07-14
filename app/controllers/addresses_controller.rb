class AddressesController < ApplicationController

  def create
    response = HTTParty.get "https://maps.googleapis.com/maps/api/geocode/json?address="+ "#{params[:address][:street]},#{params[:address][:city]},#{params[:address][:state]}=#{ENV["GOOGLE_KEY"]}"

    lat = response["results"].first["geometry"]["location"]["lat"]
    lon = response["results"].first["geometry"]["location"]["lng"]

    bus_stops = HTTParty.get "https://api.wmata.com/Bus.svc/json/jStops",
    headers: { api_key: ENV["BUS_KEY"]},
    query: {
      Lat: lat,
      Lon: lon,
      Radius: 10000
    }

    binding.pry
  end

  private

    def approved_params
      params.require(:address).permit(:street, :city, :state, :zipcode)
    end
end
