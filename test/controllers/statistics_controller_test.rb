require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test 'get page_views for non admin' do
    get :page_views
    assert_redirected_to root_path
  end

  test '@page_views for get by admin' do
    @controller.stub(:admin?, true) do
      get :page_views
    end
    assert_not_nil assigns(:page_views)
  end

  test 'get aggregated_per_user for non admin' do
    get :aggregated_per_user
    assert_redirected_to root_path
  end

  test 'assigns for get by admin' do
    @controller.stub(:admin?, true) do
      get :aggregated_per_user
    end
    assert_not_nil assigns(:users_and_pages_hash)
  end
end
