require 'test_helper'

class SearchParkingsTest < ActionDispatch::IntegrationTest
  setup { visit parkings_path }

  test "user sees a search form on parkings index" do
    assert has_content? t('search.search')
    assert has_content? t('search.private')
    assert has_content? t('search.public')
    assert has_content? t('search.min_price_hour')
    assert has_content? t('search.max_price_hour')
    assert has_content? t('search.min_price_day')
    assert has_content? t('search.max_price_day')
    assert has_content? t('search.city')
  end

  test "the search form is not cleared after form submission" do
    check t('search.private')
    check t('search.public')
    fill_in t('search.min_price_day'), with: "1"
    fill_in t('search.max_price_day'), with: "1000"
    fill_in t('search.min_price_hour'), with: "1"
    fill_in t('search.max_price_hour'), with: "2"
    fill_in t('search.city'), with: "Warszawa"
    click_on t('search.btn')
    assert has_checked_field? t('search.private')
    assert has_checked_field? t('search.public')
    assert has_field? t('search.min_price_day'), with: "1"
    assert has_field? t('search.max_price_day'), with: "1000"
    assert has_field? t('search.min_price_hour'), with: "1"
    assert has_field? t('search.max_price_hour'), with: "2"
    assert has_field? t('search.city'), with: "Warszawa"
  end

  test "after search form submission, the parkings index displays flash error if there are no search results" do
    fill_in t('search.city'), with: "London"
    click_on t('search.btn')
    assert has_content? t('search.no_results')
  end

  test "after search form submission, the parkings index displays results" do
    check t('search.private')
    click_on t('search.btn')
    assert has_content? "Warszawa 50 2.9 12.99"
    assert_not has_content? "Poznań 100 3.5 20.99"
  end

  test "after search submission, user sees parkings with hour price within specified range" do
    fill_in t('search.min_price_hour'), with: "2.9"
    fill_in t('search.max_price_hour'), with: "3"
    click_on t('search.btn')
    assert has_content? "Warszawa 50 2.9 12.99"
    assert_not has_content? "Poznań 100 3.5 20.99"
  end
end
