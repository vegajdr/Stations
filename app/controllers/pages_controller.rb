class PagesController < ApplicationController

  def index
    @address = Address.new
  end

end
