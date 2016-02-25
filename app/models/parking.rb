class Parking < ActiveRecord::Base
  has_one :address
  has_many :place_rents
  belongs_to :owner, class_name: "Person"
end
