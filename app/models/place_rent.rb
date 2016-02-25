class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking
end
