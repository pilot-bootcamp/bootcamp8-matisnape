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

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to root_path
    else
      render new_parking_path
    end
  end

  def edit
    @parking = Parking.find params[:id]
  end
  private
  def parking_params
    params.require(:parking).permit(:places, :hour_price, :day_price, :kind)
  end
end
