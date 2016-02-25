class ParkingsController < ApplicationAController

  def index
    @parkings = Parking.all
  end
end
