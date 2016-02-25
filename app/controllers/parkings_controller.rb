class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all.includes(:address)
  end

  def show
    @parking = Parking.find params[:id]
  end
end
