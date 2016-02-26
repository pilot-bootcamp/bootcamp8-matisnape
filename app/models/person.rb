class Person < ActiveRecord::Base
  has_many :parkings, foreign_key: "owner_id"
  has_many :cars, foreign_key: "owner_id", inverse_of: :owner
  validates :first_name, presence: true
end
