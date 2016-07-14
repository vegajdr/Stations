class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    binding.pry

  end
end
