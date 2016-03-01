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
    assert_equal 0, @place_rent.calculate_price.to_i
  end

  test "Price is counted for every started hour" do
    @place_rent.starts_at = DateTime.new(2015,11,19,8,37)
    @place_rent.ends_at = DateTime.new(2015,11,19,9,00)
    assert_equal 3.5, @place_rent.calculate_price.to_f
  end

  test "23 hours with minutes is counted as one day" do
    @place_rent.starts_at = DateTime.new(2015,11,19,8,37)
    @place_rent.ends_at = DateTime.new(2015,11,20,8,00)
    assert_equal 20.99, @place_rent.calculate_price.to_f
  end

  test "24 hours with minutes is counted as one day and one hour" do
    @place_rent.starts_at = DateTime.new(2015,11,19,8,37)
    @place_rent.ends_at = DateTime.new(2015,11,20,9,00)
    assert_equal 24.49, @place_rent.calculate_price.to_f
  end

  test "Price is updated after creating place rent" do
    @place_rent = PlaceRent.create(parking: parkings(:one), starts_at: DateTime.new(2015,11,19,8,00), ends_at: DateTime.new(2015,11,19,9,00), car: cars(:one))
    assert_equal 3.5, @place_rent.price
  end

  test "Open place rent is closed after parking is destroyed" do
    @place_rent = PlaceRent.create(parking: parkings(:one), starts_at: DateTime.now - 1.days, ends_at: DateTime.now + 2.days, car: cars(:one))
    @place_rent.parking.destroy
    @place_rent.reload
    assert_in_delta DateTime.now.to_i, @place_rent.ends_at.to_i, 10
  end

  test "Place rents from the past are not changed after parking is destroyed" do
    ends_at = DateTime.new(2015,11,19,9,00)
    @place_rent = PlaceRent.create(parking: parkings(:one), starts_at: DateTime.new(2015,11,19,8,00), ends_at: ends_at, car: cars(:one))
    @place_rent.parking.destroy
    @place_rent.reload
    assert_equal ends_at, @place_rent.ends_at
  end
end
