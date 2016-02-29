require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest

  setup do
    visit '/parkings'
  end

  test "user opens parkings index" do
    assert has_content? "Parkings"
  end

  test "user sees parkings" do
    assert has_content? "Poznań 100 3.5 20.99"
    assert has_content? "Warszawa 50 2.9 12.99"
  end

  test "user sees particular parking details when clicking Show" do
    click_link "Show", match: :first
    assert has_content? "Parking Poznań, Św. Marcin"
    assert_not has_content? "Warszawa 50 2.9 12.99"
  end

  test "user adds a new parking successfully with valid data" do
    click_link "Add new parking"
    fill_in "Enter city:", with: "Lublin"
    fill_in "Enter street", with: "Poznańska"
    fill_in "Enter zipcode", with: "62-024"
    fill_in "Enter number of places available:", with: "123"
    fill_in "Enter price per hour:", with: 56
    fill_in "Enter price per day:", with: 78
    select "private", from: "Enter kind:"
    click_on "Submit"
    assert has_content? "Parking has been saved correctly"
    assert has_content? "Lublin 123 56.0 78.0"
  end

  test "user fails to add a new parking with invalid data" do
    click_link "Add new parking"
    click_on "Submit"
    assert has_content? "Cannot create parking because of reasons."
  end
  end
end
