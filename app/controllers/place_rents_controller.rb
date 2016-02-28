class PlaceRentsController < ApplicationController
  def index
    @place_rents = current_person.place_rents.includes({ parking: [:address] }, :car)
  end

  def show
    @place_rent = current_person.place_rents.includes({ parking: [:address] }, :car).find(params[:id])
  end

  def new
    @place_rent = current_person.place_rents.build
  end

  def create
    @place_rent = current_person.place_rents.build(place_rent_params)
    if @place_rent.save
      flash[:success] = "Place rent has been saved correctly"
      redirect_to place_rents_path
    else
      flash.now[:error] = "Cannot create place_rent because of reasons."
      render new_place_rent_path
    end
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:starts_at, :ends_at)
  end
end
