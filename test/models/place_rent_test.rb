require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase
  setup do
    @place_rent = place_rents(:one)
  end

  test "Valid with all data present" do
    assert @place_rent.valid?
  end

  test "Invalid without start date" do
    @place_rent.starts_at = nil
    assert_not @place_rent.valid?, "can't be blank"
  end

  test "Invalid without end date" do
    @place_rent.ends_at = nil
    assert_not @place_rent.valid?, "can't be blank"
  end

  test "Invalid without parking" do
    @place_rent.parking = nil
    assert_not @place_rent.valid?, "can't be blank"
  end

  test "Invalid without car" do
    @place_rent.car = nil
    assert_not @place_rent.valid?, "can't be blank"
  end
end
