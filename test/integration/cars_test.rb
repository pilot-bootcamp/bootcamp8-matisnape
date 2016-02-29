require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  setup do
    visit '/cars'
  end

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

  test "user adds a new car successfully with valid data" do
    click_link "Add new car"
    fill_in "Enter registration number:", with: "WAW12345"
    fill_in "Enter model:", with: "Syrena Bosto"
    click_on "Submit"
    assert has_content? "Car has been saved correctly"
    assert has_content? "WAW12345 Syrena Bosto"
  end

  test "user fails to add a new car with invalid data" do
    click_link "Add new car"
    click_on "Submit"
    assert has_content? "Cannot create car because of reasons."
  end
end
