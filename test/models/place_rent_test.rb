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
    assert_not @place_rent.valid?
  end

  test "Invalid without end date" do
    @place_rent.ends_at = nil
    assert_not @place_rent.valid?
  end

  test "Invalid without parking" do
    @place_rent.parking = nil
    assert_not @place_rent.valid?
  end

  test "Invalid without car" do
    @place_rent.car = nil
    assert_not @place_rent.valid?
  end

  test "Price is 0 if start date and end date are equal" do
    @place_rent.ends_at = @place_rent.starts_at
    assert_equal 0, @place_rent.price.to_i
  end

  test "Price is counted for every started hour" do
    @place_rent.starts_at = DateTime.new(2015,11,19,8,37)
    @place_rent.ends_at = DateTime.new(2015,11,19,9,00)
    assert_equal 3.5, @place_rent.price.to_f
  end

  test "23 hours with minutes is counted as one day" do
    @place_rent.starts_at = DateTime.new(2015,11,19,8,37)
    @place_rent.ends_at = DateTime.new(2015,11,20,8,00)
    assert_equal 20.99, @place_rent.price.to_f
  end

  test "24 hours with minutes is counted as one day and one hour" do
    @place_rent.starts_at = DateTime.new(2015,11,19,8,37)
    @place_rent.ends_at = DateTime.new(2015,11,20,9,00)
    assert_equal 24.49, @place_rent.price.to_f
  end
end
