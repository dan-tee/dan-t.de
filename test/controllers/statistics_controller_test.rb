require "test_helper"

class StatisticsControllerTest < ActionController::TestCase
  test "should get page_views" do
    get :page_views
    assert_response :success
  end

  test "should get aggregated_per_user" do
    get :aggregated_per_user
    assert_response :success
  end

end
