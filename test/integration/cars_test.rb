require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  setup do
    sign_in("anna.nowak@netguru.pl", "password")
    visit cars_path
  end

  teardown do
    Capybara.reset!
  end

  describe "viewing cars" do
    test "user opens cars index" do
      assert has_content? t('cars.title')
    end

    test "user sees cars list" do
      assert has_content? "PZ12345 Fiat Panda"
      assert has_content? "WE65432 Ford Escort"
    end

    test "user sees particular car details when clicking Show" do
      click_link t('crud.show'), match: :first
      assert has_content? "PZ12345 Fiat Panda"
      assert_not has_content? "WE65432 Ford Escort"
    end

    test "user sees error message when trying to go to a nonexistent car page" do
      visit car_path(id: "bjh")
      assert has_content? t('cars.not_found')
    end
  end

  describe "adding a new car" do
    before { click_link t('cars.add_new') }

    test "user adds a new car successfully with valid data" do
      fill_in t('cars.form.registration'), with: "WAW12345"
      fill_in t('cars.form.model'), with: "Syrena Bosto"
      click_on t('buttons.submit')
      assert has_content? t('cars.form.success_msg')
      assert has_content? "WAW12345 Syrena Bosto"
    end

    test "user fails to add a new car with invalid data" do
      click_on t('buttons.submit')
      assert has_content? t('cars.form.failed_msg')
    end
  end

  describe "editing a car" do
    before { click_link t('crud.edit'), match: :first }

    test "user edits a car successfully with valid data" do
      fill_in t('cars.form.registration'), with: "LOL12345"
      fill_in t('cars.form.model'), with: "Volkswagen Polo"
      click_on t('buttons.submit')
      assert has_content? t('cars.form.success_msg')
      assert_not has_content? "WAW12345 Syrena Bosto"
      assert has_content? "LOL12345 Volkswagen Polo"
    end

    test "user fails to edit a car because of invalid data" do
      fill_in t('cars.form.registration'), with: ""
      fill_in t('cars.form.model'), with: ""
      click_on t('buttons.submit')
      assert has_content? t('cars.form.failed_update')
    end
  end

  describe "removing a car" do
    test "user removes a car successfully" do
      page.accept_confirm { click_link t('crud.delete'), match: :first }
      assert_not has_content? "PZ12345 Fiat Panda"
      assert has_content? t('cars.form.delete_success')
    end

    test "user fails to remove a car" do
      page.dismiss_confirm { click_link t('crud.delete'), match: :first }
      assert has_content? "PZ12345 Fiat Panda"
      assert has_content? "WE65432 Ford Escort"
      assert_not has_content? t('cars.form.delete_success')
    end
  end
end
