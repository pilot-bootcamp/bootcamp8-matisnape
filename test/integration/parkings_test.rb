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
  end
end
