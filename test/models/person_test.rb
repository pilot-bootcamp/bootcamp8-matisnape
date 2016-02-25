require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @person = people(:one)
  end

  test "Valid if all info is present" do
    assert @person.valid?
  end

  test "Invalid if there's no first name" do
    @person.first_name = ""
    assert_not @person.valid?, "can't be blank"
  end
end
