require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  test 'login redirects admin' do
    @controller.make_admin!
    get :new
    assert_redirected_to root_path
  end

  test "login doesn't redirect non admin" do
    get :new
    assert_select 'title', 'Login'
  end
end