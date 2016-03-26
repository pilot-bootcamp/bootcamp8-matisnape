class CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :car_not_found

  def index
    @cars = current_person.cars
  end

  def show
    car
  end

  def new
    @car = current_person.cars.build
  end

  def create
    @car = current_person.cars.build(car_params)
    if car.save
      flash[:success] = t('cars.form.success_msg')
      redirect_to cars_path
    else
      flash.now[:error] = t('cars.form.failed_msg')
      render 'new'
    end
  end

  def edit
    car
  end

  def update
    if car.update(car_params)
      flash[:success] = t('cars.form.success_msg')
      redirect_to @car
    else
      flash.now[:error] = t('cars.form.failed_update')
      render 'edit'
    end
  end

  def destroy
    if car.destroy
      flash[:success] = t('cars.form.delete_success')
    else
      flash[:error] = t('cars.form.delete_fail')
    end
    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:registration_number, :model, :image, :remove_image)
  end

  def car
    @car ||= current_person.cars.find(params[:id])
  end

  def car_not_found
    flash[:error] = t('cars.not_found')
    redirect_to cars_path
  end
end
