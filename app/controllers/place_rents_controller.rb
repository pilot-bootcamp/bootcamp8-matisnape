class PlaceRentsController < ApplicationController
  def index
    @place_rent = current_person.place_rents
  end

  def show
    @place_rent = current_person.place_rents.find params[:id]
  end
end
