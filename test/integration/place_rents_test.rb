require 'test_helper'

class PlaceRentsTest < ActionDispatch::IntegrationTest

  test "user adds a new place rent successfully with valid data" do
    visit parkings_path
    click_link "Rent a place", match: :first
    select "Fiat Panda PZ12345", from: "Select car:"
    select_date_and_time(DateTime.new(2011,11,19,8,37), from: :place_rent_starts_at)
    select_date_and_time(DateTime.new(2012,11,19,8,37), from: :place_rent_ends_at)
    click_on "Submit"
    assert has_content? "Place rent has been saved correctly"
    assert has_content? "2011-11-19 08:37:00 UTC 2012-11-19 08:37:00 UTC 61-248 Poznań, Św. Marcin
      Fiat Panda PZ12345"
  end

  # test missing for checking place rents if current user has no cars

  describe "viewing place rents index" do
    before { visit place_rents_path }

    test "user views a list of place rents" do
      assert has_content? "2016-01-24 08:15:34 UTC 2016-01-24 18:15:34 UTC 61-248 Poznań, Św. Marcin
        Fiat Panda PZ12345"
      assert has_content? "2016-02-24 10:15:34 UTC 2016-02-24 18:15:34 UTC 61-248 Poznań, Św. Marcin
        Ford Escort WE65432"
    end

    test "user can see a place rents's prices" do
      assert has_content? "Price of place rent"
      assert has_content? "PZ12345 35.0"
      assert has_content? "WE65432 28.0"
    end
  end

  describe "viewing place rent details" do
    before do
      visit place_rents_path
      click_link "Show", match: :first
    end

    test "user can view a single place rent" do
      assert has_content? "Fiat Panda PZ12345"
      assert_not has_content? "Ford Escort WE65432"
    end

    test "user can see a place rent's price on single place rent page" do
      assert has_content? "Price of place rent"
      assert has_content? "PZ12345 35.0"
      assert_not has_content? "WE65432 28.0"
    end
  end

  private

  def select_date_and_time(date, options = {})
    field = options[:from]
    select date.strftime('%Y'), :from => "#{field}_1i" #year
    select date.strftime('%B'), :from => "#{field}_2i" #month
    select date.strftime('%d'), :from => "#{field}_3i" #day
    select date.strftime('%H'), :from => "#{field}_4i" #hour
    select date.strftime('%M'), :from => "#{field}_5i" #minute
  end
end
