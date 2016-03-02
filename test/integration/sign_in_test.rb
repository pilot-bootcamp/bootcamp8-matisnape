require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest

  test "user can log in" do
    visit '/session/new'
    fill_in "Email", with: "anna.nowak@netguru.pl"
    fill_in "Password", with: "password"
    click_on "Submit"
    assert has_content? "Logged in as: Anna"
  end
end
