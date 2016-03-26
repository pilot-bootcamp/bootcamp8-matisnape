class Car < ActiveRecord::Base
  dragonfly_accessor :image

  belongs_to :owner, class_name: "Person"
  has_many :place_rents
  validates :registration_number, :model, :owner, presence: true
  validates_size_of :image, maximum: 200.kilobytes, message: "Your image is too big"
  validates_property :format, of: :image, in: ['jpg', 'jpeg', 'png', 'gif'], message: "Only jpg, png and gif are accepted."

  def display_car
    "#{model} #{registration_number}"
  end

  def to_param
    "#{id}-#{model.parameterize}"
  end
end
