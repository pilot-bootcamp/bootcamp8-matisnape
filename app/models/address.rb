class Address < ActiveRecord::Base
  has_one :parking
  validates :city, :street, :zip_code, presence: true
  validates :zip_code, format: { with: /\A\d{2}-\d{3}\z/,
                                 message: "Zip code format should be XX-XXX" }

  def display_full_address
    "#{zip_code} #{city}, #{street}"
  end
end
