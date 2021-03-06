require 'test_helper'

class AdminSessionsControllerTest < ActionController::TestCase

  def setup
    @controller.capture_statistics!
  end

  test 'login for admin' do
    @controller.make_admin!
    get :new
    assert_redirected_to root_path
  end

  test 'login for non admin' do
    get :new
    assert_select 'title', 'Login'
  end

  test 'logout for non admin' do
    get :destroy
    assert_redirected_to root_path
  end

  test 'logout for admin' do
    @controller.make_admin!
    delete :destroy
    assert_redirected_to root_path
    assert !@controller.admin?
  end

  test 'create with wrong password' do
    post :create, Password: 'wrong'
    assert !@controller.admin?
    assert_redirected_to login_path
  end

  test 'create with right password' do
    post :create, Password: 'abc'
    assert_redirected_to private_messages_path
    assert @controller.admin?
  end
end