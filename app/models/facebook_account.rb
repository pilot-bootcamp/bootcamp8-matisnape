class FacebookAccount < ActiveRecord::Base
  belongs_to :person

  validates :uid, :person, presence: true
end
