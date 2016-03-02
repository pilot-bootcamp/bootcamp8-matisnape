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
      assert has_content? "Cars"
    end

    test "user sees cars list" do
      assert has_content? "PZ12345 Fiat Panda"
      assert has_content? "WE65432 Ford Escort"
    end

    test "user sees particular car details when clicking Show" do
      click_link "Show", match: :first
      assert has_content? "PZ12345 Fiat Panda"
      assert_not has_content? "WE65432 Ford Escort"
    end

    test "user sees error message when trying to go to a nonexistent car page" do
      visit car_path("bjh")
      assert has_content? "There's no such car"
    end
  end

  describe "adding a new car" do
    before { click_link "Add new car" }

    test "user adds a new car successfully with valid data" do
      fill_in "Enter registration number:", with: "WAW12345"
      fill_in "Enter model:", with: "Syrena Bosto"
      click_on "Submit"
      assert has_content? "Car has been saved correctly"
      assert has_content? "WAW12345 Syrena Bosto"
    end

    test "user fails to add a new car with invalid data" do
      click_on "Submit"
      assert has_content? "Cannot create car because of reasons."
    end
  end

  describe "editing a car" do
    before { click_link "Edit", match: :first }

    test "user edits a car successfully with valid data" do
      fill_in "Enter registration number:", with: "LOL12345"
      fill_in "Enter model:", with: "Volkswagen Polo"
      click_on "Submit"
      assert has_content? "Car has been saved correctly"
      assert_not has_content? "WAW12345 Syrena Bosto"
      assert has_content? "LOL12345 Volkswagen Polo"
    end

    test "user fails to edit a car because of invalid data" do
      fill_in "Enter registration number:", with: ""
      fill_in "Enter model:", with: ""
      click_on "Submit"
      assert has_content? "Cannot update car because of reasons."
    end
  end

  describe "removing a car" do
    test "user removes a car successfully" do
      page.accept_confirm { click_link "Remove", match: :first }
      assert_not has_content? "PZ12345 Fiat Panda"
      assert has_content? "Car deleted successfully"
    end

    test "user fails to remove a car" do
      page.dismiss_confirm { click_link "Remove", match: :first }
      assert has_content? "PZ12345 Fiat Panda"
      assert has_content? "WE65432 Ford Escort"
      assert_not has_content? "Car deleted successfully"
    end
  end
end
