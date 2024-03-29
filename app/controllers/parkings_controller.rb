class ParkingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :parking_not_found
  helper_method :query_params
  skip_before_filter :require_login, except: [:new, :create, :edit, :destroy]

  def index
    @parkings = Parking.paginate(page: params[:page], per_page: 5).search(params[:query])
    flash[:error] = t('search.no_results') if @parkings.empty?
  end

  def show
    parking
  end

  def new
    @parking = current_person.parkings.build
  end

  def create
    @parking = current_person.parkings.build(parking_params)
    if @parking.save
      flash[:success] = t('parkings.form.success_msg')
      redirect_to root_path
    else
      flash.now[:error] = t('parkings.form.failed_msg')
      render 'new'
    end
  end

  def edit
    parking
  end

  def update
    if parking.update(parking_params)
      flash[:success] = t('parkings.form.success_msg')
      redirect_to @parking
    else
      flash.now[:error] = t('parkings.form.failed_update')
      render 'edit'
    end
  end

  def destroy
    if parking.destroy
      flash[:success] = t('parkings.form.delete_success')
    else
      flash[:error] = t('parkings.form.delete_fail')
    end
    redirect_to root_path
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :hour_price, :day_price, :kind, address_attributes: [:city, :street, :zip_code])
  end

  def parking
    @parking = Parking.find(params[:id])
  end

  def query_params
    params.permit(query: [:kind_private, :kind_public, :city, :min_hour_price, :max_hour_price, :min_day_price, :max_day_price]).fetch(:query, {})
  end

  def parking_not_found
    flash[:error] = t('parkings.not_found')
    redirect_to parkings_path
  end
end
