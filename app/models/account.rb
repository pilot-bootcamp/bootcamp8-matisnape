class Account < ActiveRecord::Base
  belongs_to :person
  has_secure_password
  accepts_nested_attributes_for :person

  validates :email, presence: true

  def self.authenticate(email, password)
    user = Account.find_by(email: email)
    user.blank? ? false : user.authenticate(password)
  end
end
