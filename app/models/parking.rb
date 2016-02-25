class Parking < ActiveRecord::Base
  belongs_to :address
  has_many :place_rents
  belongs_to :owner, class_name: "Person"

  validates :places, :hour_price, :day_price, presence: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street),
    message: "%{value} is not a valid kind" }
  validates :hour_price, :day_price, numericality: true
end
