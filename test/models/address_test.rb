require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  setup do
    @address = addresses(:one)
  end

  test "Valid with all data" do
    assert @address.valid?
  end

  test "Invalid if there's no city" do
    @address.city = ""
    assert @address.invalid?, "can't be blank"
  end

  test "Invalid if there's no street" do
    @address.street = ""
    assert @address.invalid?, "can't be blank"
  end

  test "Invalid if there's no zip code" do
    @address.zip_code = ""
    assert @address.invalid?, "can't be blank"
  end

  test "Invalid if the zip code format is wrong" do
    @address.zip_code = "1234-0"
    assert @address.invalid?, "Zip code format should be XX-XXX"
  end
end
