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
    unless @parking.save
      redirect_to new_parking_path,
        error: "Parking wasn't saved, because: #{@parking.errors.full_messages}"
    else
      redirect_to root_path
    end
  end

  private
  def parking_params
    params.require(:parking).permit(:places, :hour_price, :day_price)
  end
end
