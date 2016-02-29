require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "user opens parkings index" do
    visit '/parkings'
    assert has_content? 'Parkings'
  end
end
