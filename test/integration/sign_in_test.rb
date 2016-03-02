require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest

  teardown do
    Capybara.reset!
  end

  test "user can log in and the user's name is displayed on the page" do
    visit '/session/new'
    fill_in "Email:", with: "anna.nowak@netguru.pl"
    fill_in "Password:", with: "password"
    click_on "Log in"
    assert has_content? "Logged in as: Anna Nowak"
    assert_not has_content? "You're not logged in"
  end

  test "non-logged in user doesn't see any name on the page" do
    visit '/session/new'
    assert has_content? "You're not logged in"
    assert_not has_content? "Logged in as:"
  end
end
