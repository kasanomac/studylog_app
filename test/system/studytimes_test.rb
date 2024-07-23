require "application_system_test_case"

class StudytimesTest < ApplicationSystemTestCase
  setup do
    @studytime = studytimes(:one)
  end

  test "visiting the index" do
    visit studytimes_url
    assert_selector "h1", text: "Studytimes"
  end

  test "should create studytime" do
    visit studytimes_url
    click_on "New studytime"

    fill_in "Memo", with: @studytime.memo
    fill_in "Studytime hours", with: @studytime.studytime_hours
    fill_in "Studytime minutes", with: @studytime.studytime_minutes
    click_on "Create Studytime"

    assert_text "Studytime was successfully created"
    click_on "Back"
  end

  test "should update Studytime" do
    visit studytime_url(@studytime)
    click_on "Edit this studytime", match: :first

    fill_in "Memo", with: @studytime.memo
    fill_in "Studytime hours", with: @studytime.studytime_hours
    fill_in "Studytime minutes", with: @studytime.studytime_minutes
    click_on "Update Studytime"

    assert_text "Studytime was successfully updated"
    click_on "Back"
  end

  test "should destroy Studytime" do
    visit studytime_url(@studytime)
    click_on "Destroy this studytime", match: :first

    assert_text "Studytime was successfully destroyed"
  end
end
