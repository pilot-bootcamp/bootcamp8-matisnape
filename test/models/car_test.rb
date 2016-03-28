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
    assert_not @car.valid?
    assert_equal ["can't be blank"], @car.errors.messages[:registration_number]
  end

  test "Invalid without model" do
    @car.model = ""
    assert_not @car.valid?
    assert_equal ["can't be blank"], @car.errors.messages[:model]
  end

  test "Invalid without owner" do
    @car.owner = nil
    assert_not @car.valid?
    assert_equal ["can't be blank"], @car.errors.messages[:owner]
  end

  test "URL contains model name" do
    assert_equal "#{@car.id}-#{@car.model.parameterize}", @car.to_param
  end

  test "Validates car image file size" do
    @car.image = Rails.root + 'test/fixtures/images/too_big_image.png'
    assert_not @car.valid?
    assert_equal ["Your image is too big"], @car.errors.messages[:image]
  end

  test "Validates car image file format" do
    @car.image = Rails.root + 'test/fixtures/images/wrong_file_format.pdf'
    assert_not @car.valid?
    assert_equal ["Only jpg, png and gif are accepted."], @car.errors.messages[:image]
  end

  test "Valid with valid image" do
    @car.image = Rails.root + 'test/fixtures/images/valid_image.jpg'
    assert @car.valid?
  end
end
