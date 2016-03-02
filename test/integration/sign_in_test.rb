require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest

  test "user can log in and the user's name is displayed on the page" do
    visit '/session/new'
    fill_in "Email", with: "anna.nowak@netguru.pl"
    fill_in "Password", with: "password"
    click_on "Submit"
    assert has_content? "Logged in as: Anna"
    assert_not has_content? "Log in"
  end

  test "non-logged in user doesn't see any name on the page" do
    visit '/session/new'
    assert has_content? "Log in"
    assert_not has_content? "Logged in as:"
  end
end
