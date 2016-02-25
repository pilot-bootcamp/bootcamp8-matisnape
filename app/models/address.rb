class Address < ActiveRecord::Base
  belongs_to :parking
  validates :city, :street, :zip_code, presence: true
  validates :zip_code, format: { with: /\A\d{2}-\d{3}\z/,
    message: "Zip code format should be XX-XXX" }
end
