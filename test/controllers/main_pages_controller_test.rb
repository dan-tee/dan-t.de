require 'test_helper'

class MainPagesControllerTest < ActionController::TestCase
  test 'should get home' do
    get :home
    assert_response :success
  end

  test 'should get about' do
    get :cv
    assert_response :success
  end
end
