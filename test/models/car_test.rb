require 'test_helper'

class CarTest < ActiveSupport::TestCase
  setup do
    @car = cars(:one)
  end

  test "Valid with all data present" do
    assert @car.valid?
  end

  test "Invalid without registration number" do
    @car.registration_number = ""
    assert_not @car.valid?, "can't be blank"
  end

  test "Invalid without model" do
    @car.model = ""
    assert_not @car.valid?, "can't be blank"
  end

  test "Invalid without owner" do
    @car.owner = nil
    assert_not @car.valid?, "can't be blank"
  end
end
