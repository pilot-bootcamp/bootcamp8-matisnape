class Car < ActiveRecord::Base
  belongs_to :owner, class_name: "Person", dependent: :destroy
  has_many :place_rents
  accepts_nested_attributes_for :owner,
    allow_destroy: true
  validates :registration_number, :model, :owner, presence: true
end
