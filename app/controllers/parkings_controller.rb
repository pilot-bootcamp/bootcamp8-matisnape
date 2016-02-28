class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all.includes(:address)
  end

  def show
    parking
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
    parking
  end

  def update
    if parking.update(parking_params)
      flash[:success] = "Parking has been saved correctly"
      redirect_to @parking
    else
      flash.now[:error] = "Cannot update parking because of reasons."
      render 'edit'
    end
  end

  def destroy
    if parking.destroy
      flash[:success] = "Parking deleted successfully"
    else
      flash[:error] = "Cannot delete parking"
    end
    redirect_to root_path
  end

  private
  def parking_params
    params.require(:parking).permit(:places, :hour_price, :day_price, :kind, address_attributes: [ :city, :street, :zip_code ])
  end

  def parking
    @parking = Parking.find(params[:id])
  end
end
