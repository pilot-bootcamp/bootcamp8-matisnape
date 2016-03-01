require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest

  setup do
    visit parkings_path
  end

  describe "viewing parkings" do
    it "user opens parkings index" do
      assert has_content? "Parkings"
    end

    it "user sees parkings" do
      assert has_content? "Poznań 100 3.5 20.99"
      assert has_content? "Warszawa 50 2.9 12.99"
    end

    it "user sees particular parking details when clicking Show" do
      click_link "Show", match: :first
      assert has_content? "Parking Poznań, Św. Marcin"
      assert_not has_content? "Warszawa 50 2.9 12.99"
    end
  end

  describe "adding a new parking" do
    before { click_link "Add new parking" }

    test "user adds a new parking successfully with valid data" do
      fill_in "Enter city:", with: "Lublin"
      fill_in "Enter street", with: "Poznańska"
      fill_in "Enter zipcode", with: "62-024"
      fill_in "Enter number of places available:", with: "123"
      fill_in "Enter price per hour:", with: 56
      fill_in "Enter price per day:", with: 78
      select "private", from: "Enter kind:"
      click_on "Submit"
      assert has_content? "Parking has been saved correctly"
      assert has_content? "Lublin 123 56.0 78.0"
    end

    test "user fails to add a new parking with invalid data" do
      click_on "Submit"
      assert has_content? "Cannot create parking because of reasons."
    end
  end

  describe "editing a parking" do
    before { click_link "Edit", match: :first }

    test "user edits a parking successfully" do
      fill_in "Enter city:", with: "Lublin"
      fill_in "Enter street", with: "Poznańska"
      fill_in "Enter zipcode", with: "62-024"
      fill_in "Enter number of places available:", with: "123"
      fill_in "Enter price per hour:", with: 56
      fill_in "Enter price per day:", with: 78
      select "private", from: "Enter kind:"
      click_on "Submit"
      assert has_content? "Parking has been saved correctly"
      assert has_content? "Lublin 123 56.0 78.0"
      assert_not has_content? "Poznań 100 3.5 20.99"
    end

    test "user fails to edit a parking because of invalid data" do
      fill_in "Enter city:", with: ""
      fill_in "Enter street", with: ""
      fill_in "Enter zipcode", with: ""
      fill_in "Enter number of places available:", with: ""
      fill_in "Enter price per hour:", with: nil
      fill_in "Enter price per day:", with: nil
      select "private", from: "Enter kind:"
      click_on "Submit"
      assert has_content? "Cannot update parking because of reasons."
    end
  end

  describe "removing a parking" do
    test "user removes a parking successfully" do
      page.accept_confirm { click_link "Remove", match: :first }
      assert_not has_content? "Poznań 100 3.5 20.99"
      assert has_content? "Parking deleted successfully"
    end

    test "user fails to remove a parking" do
      page.dismiss_confirm { click_link "Remove", match: :first }
      assert has_content? "Poznań 100 3.5 20.99"
      assert has_content? "Warszawa 50 2.9 12.99"
      assert_not has_content? "Parking deleted successfully"
    end
  end
end
