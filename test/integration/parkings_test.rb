require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  teardown do
    Capybara.reset!
  end

  describe "viewing parkings" do
    setup do
      visit parkings_path
    end

    it "user opens parkings index" do
      assert has_content? t('parkings.title')
    end

    it "user sees parkings" do
      assert has_content? "Poznań 100 3.5 20.99"
      assert has_content? "Warszawa 50 2.9 12.99"
    end

    it "user sees particular parking details when clicking Show" do
      click_link t('crud.show'), match: :first
      assert has_content? "Parking: Poznań, Św. Marcin"
      assert_not has_content? "Warszawa 50 2.9 12.99"
    end

    it "user sees error message when trying to go to a nonexistent parking page" do
      visit parking_path(id: "bjh")
      assert has_content? t('parkings.not_found')
    end

    describe "unlogged user" do
      it "cannot view create new parking" do
        click_link t('parkings.add_new')
        assert has_content? t('errors.restricted')
      end

      it "cannot delete a parking" do
        click_link t('crud.delete'), match: :first
        assert has_content? t('errors.restricted')
      end
    end
  end

  describe "logged user" do
    before { sign_in("anna.nowak@netguru.pl", "password") }

    describe "adding a new parking" do
      before { click_link t('parkings.add_new') }

      test "user adds a new parking successfully with valid data" do
        fill_in t('parkings.form.city'), with: "Lublin"
        fill_in t('parkings.form.street'), with: "Poznańska"
        fill_in t('parkings.form.zip_code'), with: "62-024"
        fill_in t('parkings.form.places'), with: "123"
        fill_in t('parkings.form.price_hour'), with: 56
        fill_in t('parkings.form.price_day'), with: 78
        select t('parkings.kinds.private'), from: t('parkings.form.kind')
        click_on t('buttons.submit')
        assert has_content? t('parkings.form.success_msg')
        assert has_content? "Lublin 123 56.0 78.0"
      end

      test "user fails to add a new parking with invalid data" do
        click_on "Submit"
        assert has_content? t('parkings.form.failed_msg')
      end
    end

    describe "editing a parking" do
      before { click_link t('crud.edit'), match: :first }

      test "user edits a parking successfully" do
        fill_in t('parkings.form.city'), with: "Lublin"
        fill_in t('parkings.form.street'), with: "Poznańska"
        fill_in t('parkings.form.zip_code'), with: "62-024"
        fill_in t('parkings.form.places'), with: "123"
        fill_in t('parkings.form.price_hour'), with: 56
        fill_in t('parkings.form.price_day'), with: 78
        select t('parkings.kinds.private'), from: t('parkings.form.kind')
        click_on t('buttons.submit')
        assert has_content? t('parkings.form.success_msg')
        assert has_content? "Lublin 123 56.0 78.0"
        assert_not has_content? "Poznań 100 3.5 20.99"
      end

      test "user fails to edit a parking because of invalid data" do
        fill_in t('parkings.form.city'), with: ""
        fill_in t('parkings.form.street'), with: ""
        fill_in t('parkings.form.zip_code'), with: ""
        fill_in t('parkings.form.places'), with: ""
        fill_in t('parkings.form.price_hour'), with: nil
        fill_in t('parkings.form.price_day'), with: nil
        select t('parkings.kinds.private'), from: t('parkings.form.kind')
        click_on t('buttons.submit')
        assert has_content? t('parkings.form.failed_update')
      end
    end

    describe "removing a parking" do
      before { visit parkings_path }

      test "user removes a parking successfully" do
        page.accept_confirm { click_link t('crud.delete'), match: :first }
        assert_not has_content? "Poznań 100 3.5 20.99"
        assert has_content? t('parkings.form.delete_success')
      end

      test "user fails to remove a parking" do
        page.dismiss_confirm { click_link t('crud.delete'), match: :first }
        assert has_content? "Poznań 100 3.5 20.99"
        assert has_content? "Warszawa 50 2.9 12.99"
        assert_not has_content? t('parkings.form.delete_success')
      end
    end
  end
end
