require "application_system_test_case"

class CountingsTest < ApplicationSystemTestCase
  setup do
    @counting = countings(:one)
  end

  test "visiting the index" do
    visit countings_url
    assert_selector "h1", text: "Countings"
  end

  test "creating a Counting" do
    visit countings_url
    click_on "New Counting"

    click_on "Create Counting"

    assert_text "Counting was successfully created"
    click_on "Back"
  end

  test "updating a Counting" do
    visit countings_url
    click_on "Edit", match: :first

    click_on "Update Counting"

    assert_text "Counting was successfully updated"
    click_on "Back"
  end

  test "destroying a Counting" do
    visit countings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Counting was successfully destroyed"
  end
end
