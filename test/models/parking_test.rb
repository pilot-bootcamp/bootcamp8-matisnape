require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  setup do
    @parking = parkings(:one)
  end

  test "Valid with all data present" do
    assert @parking.valid?
  end

  test "Invalid without number of places" do
    @parking.places = nil
    assert_not @parking.valid?, "can't be blank"
  end

  test "Invalid without hour price" do
    @parking.hour_price = nil
    assert_not @parking.valid?, "can't be blank"
  end

  test "Invalid without day price" do
    @parking.day_price = nil
    assert_not @parking.valid?, "can't be blank"
  end

  test "Invalid without owner" do
    @parking.owner = nil
    assert_not @parking.valid?, "can't be blank"
  end

  test "Invalid if kind is different from select options" do
    @parking.kind = ""
    assert_not @parking.valid?, "%{value} is not a valid kind"
  end
end
