require 'test_helper'

class SearchParkingsTest < ActionDispatch::IntegrationTest
  setup { visit parkings_path }

  test "user sees a search form on parkings index" do
    assert has_content? "Search Private parkings Public parkings"
    assert has_content? "Min. price per hour: Max. price per hour:"
    assert has_content? "Min. price per day: Max. price per day:"
    assert has_content? "Parking city:"
  end

  test "the search form is not cleared after form submission" do
    check "Private parkings"
    check "Public parkings"
    fill_in "Min. price per day:", with: "1"
    fill_in "Max. price per day:", with: "1000"
    fill_in "Min. price per hour:", with: "1"
    fill_in "Max. price per hour:", with: "2"
    fill_in "Parking city:", with: "Warszawa"
    click_on "Search"
    assert has_checked_field? "Private parkings"
    assert has_checked_field? "Public parkings"
    assert has_field? "Min. price per day:", with: "1"
    assert has_field? "Max. price per day:", with: "1000"
    assert has_field? "Min. price per hour:", with: "1"
    assert has_field? "Max. price per hour:", with: "2"
    assert has_field? "Parking city", with: "Warszawa"
  end
end
