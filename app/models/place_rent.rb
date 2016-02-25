class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates :starts_at, :ends_at, :parking, :car, presence: true
end
