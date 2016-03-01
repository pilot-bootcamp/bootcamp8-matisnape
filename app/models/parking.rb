class Parking < ActiveRecord::Base
  belongs_to :address
  has_many :place_rents
  belongs_to :owner, class_name: "Person"
  accepts_nested_attributes_for :address

  validates :places, :hour_price, :day_price, :address, :owner, presence: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street),
    message: "%{value} is not a valid kind" }
  validates :hour_price, :day_price, numericality: true

  after_destroy :close_place_rents

  private

  def close_place_rents
    time = DateTime.now
    open_place_rents = place_rents.open(time)
    open_place_rents.update_all(ends_at: time)
  end
end
