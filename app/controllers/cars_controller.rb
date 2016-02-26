class CarsController < ApplicationController
  def index
    @cars = current_person.cars
  end

  def show
    @car = current_person.cars.find params[:id]
  end

  def new
    @car = current_person.cars.build
  end

  def create
    @car = current_person.cars.build(car_params)
    if @car.save
      flash[:success] = "Car has been saved correctly"
      redirect_to cars_path
    else
      flash.now[:error] = "Cannot create car because of reasons."
      render new_car_path
    end
  end

  def edit
    @car = current_person.cars.find params[:id]
  end

  def update
    @car = current_person.cars.find params[:id]

    if @car.update(car_params)
      flash[:success] = "Car has been saved correctly"
      redirect_to @car
    else
      flash.now[:error] = "Cannot update car because of reasons."
      render 'edit'
    end
  end

  def destroy
    @car = current_person.cars.find params[:id]
    if @car.destroy
      redirect_to cars_path
    else
      flash[:error] = "Cannot delete this car"
      redirect_to cars_path
    end
  end

  def car_params
    params.require(:car).permit(:registration_number, :model, owner_attributes: [ :first_name, :last_name ])
  end
end
