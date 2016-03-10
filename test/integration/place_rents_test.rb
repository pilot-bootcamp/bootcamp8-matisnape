require 'test_helper'

class PlaceRentsTest < ActionDispatch::IntegrationTest
  teardown do
    Capybara.reset!
  end

  describe "logged in user" do
    test "user adds a new place rent successfully with valid data" do
      sign_in("anna.nowak@netguru.pl", "password")
      click_link t('parkings.rent_place'), match: :first
      select "Fiat Panda PZ12345", from: t('place_rents.form.select_car')
      select_date_and_time(DateTime.new(2011, 11, 19, 8, 37), from: :place_rent_starts_at)
      select_date_and_time(DateTime.new(2012, 11, 19, 8, 37), from: :place_rent_ends_at)
      click_on t('buttons.submit')
      assert has_content? t('place_rents.form.success_msg')
      assert has_content? "2011-11-19 08:37:00 UTC 2012-11-19 08:37:00 UTC 61-248 Poznań, Św. Marcin
        Fiat Panda PZ12345"
    end

    test "user without any cars cannot create a place rent" do
      sign_in("nocar@example.com", "password")
      click_link t('parkings.rent_place'), match: :first
      assert has_content? t('place_rents.form.car_first')
      assert_equal new_car_path, current_path
    end

    describe "viewing place rents index" do
      before do
        sign_in("anna.nowak@netguru.pl", "password")
        visit place_rents_path
      end

      test "user views a list of place rents" do
        assert has_content? "2016-01-24 08:15:34 UTC 2016-01-24 18:15:34 UTC 61-248 Poznań, Św. Marcin
          Fiat Panda PZ12345"
        assert has_content? "2016-02-24 10:15:34 UTC 2016-02-24 18:15:34 UTC 61-248 Poznań, Św. Marcin
          Ford Escort WE65432"
      end

      test "user can see a place rents's prices" do
        assert has_content? t('place_rents.price')
        assert has_content? "PZ12345 35.0"
        assert has_content? "WE65432 28.0"
      end
    end

    describe "viewing place rent details" do
      before do
        sign_in("anna.nowak@netguru.pl", "password")
        visit place_rent_path(place_rents(:one))
      end

      test "user can view a single place rent" do
        assert has_content? "Fiat Panda PZ12345"
        assert_not has_content? "Ford Escort WE65432"
        assert_match place_rents(:one).uuid, place_rent_path(place_rents(:one))
      end

      test "user can see a place rent's price on single place rent page" do
        assert has_content? t('place_rents.price')
        assert has_content? "PZ12345 35.0"
        assert_not has_content? "WE65432 28.0"
      end
    end
  end

  describe "unlogged user" do
    test "cannot see place rents page" do
      visit place_rents_path
      assert has_content? t('errors.restricted')
    end

    test "cannot add a new place rent" do
      visit parkings_path
      click_link t('parkings.rent_place'), match: :first
      assert has_content? t('errors.restricted')
    end

    test "cannot view a single place rent" do
      visit place_rent_path(place_rents(:one))
      assert has_content? t('errors.restricted')
    end
  end

  private

  def select_date_and_time(date, options = {})
    field = options[:from]
    select date.strftime('%Y'), from: "#{field}_1i" # year
    select date.strftime('%B'), from: "#{field}_2i" # month
    select date.strftime('%d'), from: "#{field}_3i" # day
    select date.strftime('%H'), from: "#{field}_4i" # hour
    select date.strftime('%M'), from: "#{field}_5i" # minute
  end
end
