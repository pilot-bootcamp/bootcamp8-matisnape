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
end
