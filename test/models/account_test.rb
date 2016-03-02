require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:one)
  end
  test "Account with unregistered email returns false" do
    assert_equal false, Account.authenticate("wrong@email.com", @account.password)
  end

  test "Account with wrong password returns false" do
    assert_equal false, Account.authenticate(@account.email, "wrongpassword")
  end

  test "Account with correct email and password returns account" do
    assert_equal @account, Account.authenticate(@account.email, "password")
  end
end
