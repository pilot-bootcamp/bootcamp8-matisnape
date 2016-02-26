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
      flash[:success] = "Parking has been saved correctly"
      redirect_to root_path
    else
      flash.now[:error] = "Cannot create parking because of reasons."
      render new_parking_path
    end
  end

  def edit
    @parking = Parking.find params[:id]
  end

  def update
    @parking = Parking.find params[:id]

    if @parking.update(parking_params)
      flash[:success] = "Parking has been saved correctly"
      redirect_to @parking
    else
      flash.now[:error] = "Cannot update parking because of reasons."
      render 'edit'
    end
  end

  def destroy
    @parking = Parking.find params[:id]
    if @parking.destroy
      redirect_to root_path
    else
      flash[:error] = "Cannot delete parking"
      redirect_to root_path
    end
  end

  private
  def parking_params
    params.require(:parking).permit(:places, :hour_price, :day_price, :kind, address_attributes: [ :city, :street, :zip_code ])
  end
end
