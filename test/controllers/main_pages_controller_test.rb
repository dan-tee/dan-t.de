require 'test_helper'

class MainPagesControllerTest < ActionController::TestCase
  test 'get home' do
    get :home
    assert_response :success
    assert_select 'title', 'Dan-T'
  end

  test 'get about' do
    get :cv
    assert_response :success
    assert_select 'title', 'CV'
  end

  test 'get discuss' do
    get :discuss
    assert_response :success
    assert_select 'title', 'Discuss'
  end
end
