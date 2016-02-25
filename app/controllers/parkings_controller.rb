class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all.includes(:address)
  end

  def show
    @parking = Parking.find params[:id]
  end

  def new
    @parking = Parking.new
  end

  private
  def parking_params
    params.require(:parking).permit(:places, :hour_price, :day_price)
  end
end
