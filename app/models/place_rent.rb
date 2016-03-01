class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates :starts_at, :ends_at, :parking, :car, presence: true

  def price
    total_hours = ((ends_at - starts_at)/3600).ceil
    days, hours = total_hours.divmod(24)
    parking.day_price * days + parking.hour_price * hours
  end
end
