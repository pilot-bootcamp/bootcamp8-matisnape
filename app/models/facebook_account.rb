class FacebookAccount < ActiveRecord::Base
  belongs_to :person
  accepts_nested_attributes_for :person

  validates :uid, :person, presence: true

  def self.find_or_create_for_facebook(auth)
    user = FacebookAccount.find_by(uid: auth['uid'])
    if user.blank?
      user = FacebookAccount.create(uid: auth['uid'])
      person = Person.create(first_name: auth['info']['first_name'], last_name: auth['info']['last_name'])
    end
  end
end
