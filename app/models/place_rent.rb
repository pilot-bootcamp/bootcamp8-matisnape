class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates :starts_at, :ends_at, :parking, :car, presence: true

  before_create :calculate_price
  before_create :generate_uuid, unless: :uuid?

  scope :open, -> (time) { where("? BETWEEN starts_at AND ends_at", time) }

  def calculate_price
    total_hours = ((ends_at - starts_at) / 3600).ceil
    days, hours = total_hours.divmod(24)
    self.price = parking.day_price * days + parking.hour_price * hours
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def to_param
    "#{id}-#{uuid}"
  end
end
