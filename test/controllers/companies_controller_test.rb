require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get companies_index_url
    assert_response :success
  end

  test "should get fetch" do
    get companies_fetch_url
    assert_response :success
  end
end
