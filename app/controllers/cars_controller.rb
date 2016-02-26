class CarsController < ApplicationController
  def index
    @cars = Car.all.includes(:owner)
  end

  def show
    @car = Car.find params[:id]
  end

  def new
    @car = Car.new
  end

  def create
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