class FacebookAccount < ActiveRecord::Base
  belongs_to :person

  validates :uid, :person, presence: true

  def self.find_or_create_for_facebook(auth)
    user = find_by(uid: auth[:uid])
    return user if user.present?
    person = Person.create!(first_name: auth[:info][:first_name], last_name: auth[:info][:last_name])
    create(uid: auth[:uid], person: person)
  end
end
