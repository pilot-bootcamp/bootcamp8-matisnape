require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  setup do
    @parking = parkings(:one)
  end

  test "Valid with all data present" do
    assert @parking.valid?
  end

  test "Invalid without address" do
    @parking.address = nil
    assert_not @parking.valid?
  end

  test "Invalid without number of places" do
    @parking.places = nil
    assert_not @parking.valid?
  end

  test "Invalid without hour price" do
    @parking.hour_price = nil
    assert_not @parking.valid?
  end

  test "Invalid without day price" do
    @parking.day_price = nil
    assert_not @parking.valid?
  end

  test "Invalid without owner" do
    @parking.owner = nil
    assert_not @parking.valid?
  end

  test "Invalid if kind is different from select options" do
    @parking.kind = ""
    assert_not @parking.valid?
  end

  test "Invalid if hour price is not a number" do
    @parking.hour_price = "rand"
    assert_not @parking.valid?
  end

  test "Invalid if day price is not a number" do
    @parking.day_price = ""
    assert_not @parking.valid?
  end

  describe "scopes" do
    setup do
      @parking2 = parkings(:two)
      @parking3 = parkings(:three)
    end

    test "Displays public parkings" do
      assert_equal [@parking, @parking3], Parking.public_parkings
    end

    test "Displays private parkings" do
      assert_equal [@parking2], Parking.private_parkings
    end

    test "Displays parkings from a city" do
      assert_equal [@parking3], Parking.parkings_from('Wrocław')
    end

    test "Displays parkings with hour price withing range" do
      assert_equal [@parking, @parking2], Parking.hourprice_between(1,5)
    end

    test "Displays parkings with day price within range" do
      assert_equal [@parking, @parking2], Parking.dayprice_between(1,30)
    end
  end
end
