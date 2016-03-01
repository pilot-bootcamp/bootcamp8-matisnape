class Person < ActiveRecord::Base
  has_many :parkings, foreign_key: "owner_id"
  has_many :cars, foreign_key: "owner_id",
    inverse_of: :owner,
    dependent: :destroy
  has_many :place_rents, through: :cars
  validates :first_name, presence: true

  def fullname
    last_name.present? ? "#{first_name} #{last_name}" : first_name
  end
end
