class Account < ActiveRecord::Base
  belongs_to :person
  has_secure_password

  validates :email, :password, presence: true

  def self.authenticate(email, password)
    user = Account.find_by(email: email)
    user.blank? ? false : user.authenticate(password)
  end
end
