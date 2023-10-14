require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get privacy_policy" do
    get home_privacy_policy_url
    assert_response :success
  end
end
