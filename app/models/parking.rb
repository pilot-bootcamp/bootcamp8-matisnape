class Parking < ActiveRecord::Base
  belongs_to :address
  has_many :place_rents
  belongs_to :owner, class_name: "Person"
  accepts_nested_attributes_for :address

  validates :places, :hour_price, :day_price, :address, :owner, presence: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street),
    message: "%{value} is not a valid kind" }
  validates :hour_price, :day_price, numericality: true

  scope :private_parkings, -> { where(kind: "private") }
  scope :public_parkings, -> { where.not(kind: "private") }
  scope :parkings_from, -> (city) { joins(:address).where("addresses.city ILIKE ?", city) }
  scope :dayprice_between, -> (min, max) { where("day_price > ? AND day_price < ?", min, max) }
  scope :hourprice_between, -> (min, max) { where("hour_price > ? AND hour_price < ?", min, max) }

  after_destroy :close_place_rents

  private

  def close_place_rents
    time = DateTime.now
    open_place_rents = place_rents.open(time)
    open_place_rents.update_all(ends_at: time)
  end
end
