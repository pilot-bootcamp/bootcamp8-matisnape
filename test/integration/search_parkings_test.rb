require 'test_helper'

class SearchParkingsTest < ActionDispatch::IntegrationTest

  test "user sees a search form on parkings index" do
    visit parkings_path
    assert has_content? "Search Private parkings Public parkings"
    assert has_content? "Min. price per hour: Max. price per hour:"
    assert has_content? "Min. price per day: Max. price per day:"
    assert has_content? "Parking city:"
  end
end
