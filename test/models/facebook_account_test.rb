require 'test_helper'

class FacebookAccountTest < ActiveSupport::TestCase
  setup do
    @auth = { uid: '987', info: { first_name: "Dana", last_name: "Scully" }}
    @dana = FacebookAccount.first
  end

  test "Facebook Account and Person is created from data imported from Facebook" do
    facebook_accounts_count = FacebookAccount.count
    person_accounts_count = Person.count
    FacebookAccount.find_or_create_for_facebook(@auth)
    assert_equal facebook_accounts_count + 1, FacebookAccount.count
    assert_equal person_accounts_count + 1, Person.count
  end

  test "Facebook Account returns user if there's one associated with certain uid" do
    facebook_accounts_count = FacebookAccount.count
    user = FacebookAccount.find_or_create_for_facebook({ uid: @dana.uid })
    assert_equal facebook_accounts_count, FacebookAccount.count
    assert_equal @dana, user
  end
end
