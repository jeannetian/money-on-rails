require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    sign_in users(:jeanne)
    get root_path
    assert_response :success
  end
end
