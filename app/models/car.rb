class Car < ActiveRecord::Base
  belongs_to :owner, class_name: "Person"
  has_many :place_rents
  validates :registration_number, :model, :owner_id, presence: true
end
