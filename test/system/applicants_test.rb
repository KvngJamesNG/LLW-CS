require "application_system_test_case"

class ApplicantsTest < ApplicationSystemTestCase
  setup do
    @applicant = applicants(:one)
  end

  test "visiting the index" do
    visit applicants_url
    assert_selector "h1", text: "Applicants"
  end

  test "should create applicant" do
    visit applicants_url
    click_on "New applicant"

    fill_in "Cv", with: @applicant.cv
    fill_in "Email", with: @applicant.email
    fill_in "Message", with: @applicant.message
    fill_in "Name", with: @applicant.name
    fill_in "Other documents", with: @applicant.other_documents
    fill_in "Phone", with: @applicant.phone
    click_on "Create Applicant"

    assert_text "Applicant was successfully created"
    click_on "Back"
  end

  test "should update Applicant" do
    visit applicant_url(@applicant)
    click_on "Edit this applicant", match: :first

    fill_in "Cv", with: @applicant.cv
    fill_in "Email", with: @applicant.email
    fill_in "Message", with: @applicant.message
    fill_in "Name", with: @applicant.name
    fill_in "Other documents", with: @applicant.other_documents
    fill_in "Phone", with: @applicant.phone
    click_on "Update Applicant"

    assert_text "Applicant was successfully updated"
    click_on "Back"
  end

  test "should destroy Applicant" do
    visit applicant_url(@applicant)
    click_on "Destroy this applicant", match: :first

    assert_text "Applicant was successfully destroyed"
  end
end
