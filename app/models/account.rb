class Account < ActiveRecord::Base
  belongs_to :person

  validates :email, :password, presence: true
end
