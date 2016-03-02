require 'test_helper'

class SignInSignOutTest < ActionDispatch::IntegrationTest

  teardown do
    Capybara.reset!
  end

  describe "Logging in" do
    test "user can log in and the user's name is displayed on the page" do
      visit '/session/new'
      fill_in "Email:", with: "anna.nowak@netguru.pl"
      fill_in "Password:", with: "password"
      click_button "Sign in"
      assert has_content? "Logged in as: Anna Nowak"
      assert_not has_content? "You're not logged in"
    end

    test "non-logged in user doesn't see any name on the page" do
      visit '/session/new'
      assert has_content? "You're not logged in"
      assert_not has_content? "Logged in as:"
    end
  end

  describe "Logging out" do
    test "user can log out" do
      visit '/session/new'
      fill_in "Email:", with: "anna.nowak@netguru.pl"
      fill_in "Password:", with: "password"
      click_button "Sign in"
      click_on "Log out"
      assert has_content? "You have successfully logged out."
      assert has_content? "You're not logged in"
      assert_equal current_path, root_path
    end
  end
end
