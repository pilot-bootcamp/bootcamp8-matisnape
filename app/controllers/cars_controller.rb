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
    @car = Car.find params[:id]
  end

  def delete
    @car = Car.find params[:id]
    @car.destroy
    redirect_to cars_path
  end
end
