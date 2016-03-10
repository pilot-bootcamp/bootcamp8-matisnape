require 'test_helper'

class SignInSignOutTest < ActionDispatch::IntegrationTest
  teardown do
    Capybara.reset!
  end

  describe "Logging in" do
    test "user can log in and the user's name is displayed on the page" do
      visit login_path
      fill_in t('user.form.email'), with: "anna.nowak@netguru.pl"
      fill_in t('user.form.password'), with: "password"
      click_button t('user.sign_in')
      assert has_content? t('user.form.login_success')
      assert has_content? "#{t('user.logged_in_as')} Anna Nowak"
      assert_not has_content? t('user.not_loggedin')
      assert_equal current_path, root_path
    end

    test "non-logged in user doesn't see any name on the page" do
      visit login_path
      assert has_content? t('user.not_loggedin')
      assert_not has_content? t('user.logged_in_as')
    end

    test "user cannot log in with invalid credentials" do
      visit login_path
      fill_in t('user.form.email'), with: ""
      fill_in t('user.form.password'), with: ""
      click_button t('user.sign_in')
      assert has_content? t('user.form.login_fail')
      assert_not has_content? t('user.logged_in_as')
      assert has_content? t('user.not_loggedin')
    end

    describe "from specific location" do
      test "from cars path redirects back to car path" do
        visit cars_path
        sign_in("anna.nowak@netguru.pl", "password")
        assert has_content? t('user.form.login_success')
        assert_equal current_path, cars_path
      end

      test "from new parking path redirects back to new parking path" do
        visit new_parking_path
        sign_in("anna.nowak@netguru.pl", "password")
        assert has_content? t('user.form.login_success')
        assert_equal current_path, new_parking_path
      end

      test "from new session path redirects to root" do
        visit login_path
        sign_in("anna.nowak@netguru.pl", "password")
        assert has_content? t('user.form.login_success')
        assert_equal current_path, root_path
      end
    end
  end

  describe "Logging out" do
    test "user can log out" do
      visit login_path
      sign_in("anna.nowak@netguru.pl", "password")
      click_on t('user.log_out')
      assert has_content? t('user.form.logout_success')
      assert has_content? t('user.not_loggedin')
      assert_equal current_path, root_path
    end
  end

  describe "Sign in" do
    setup { visit register_path }
    test "valid signup information" do
      fill_in t('user.form.email'), with: "registeruser@example.com"
      fill_in t('user.form.password'), with: "password"
      fill_in t('user.form.password_confirmation'), with: "password"
      fill_in t('user.form.first_name'), with: "Teresa"
      fill_in t('user.form.last_name'), with: "Kowalska"
      click_button t('user.register')
      assert has_content? t('user.form.success_msg')
      assert Account.find_by(email: "registeruser@example.com").present?
    end

    test "invalid signup" do
      click_button t('user.register')
      assert has_content? t('user.form.failed_msg')
    end
  end
end
