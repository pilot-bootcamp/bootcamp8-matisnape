class PlaceRentsController < ApplicationController
  def index
    @place_rent = PlaceRent.all.includes(:car, :parking)
  end

  def show
    @place_rent = PlaceRent.find params[:id]
  end
end
