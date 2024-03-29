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

  test "Display full name of current user" do
    assert_equal "Anna Nowak", @person.full_name
  end

  test "Display only first name of current user if last name is empty" do
    @person.last_name = ""
    assert_equal "Anna", @person.full_name
  end

  test "Display only first name of current user if last name is nil" do
    @person.last_name = nil
    assert_equal "Anna", @person.full_name
  end
end
